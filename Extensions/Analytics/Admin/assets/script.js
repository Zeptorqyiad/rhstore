const COLORS = {
    RED: '#99453d',
    BLUE: '#7a83cc',
    GRAY: '#cc8fb2',
    GRAY_LIGHT: '#f9c7d9',
    GRAY_LIGHTER: '#f9c7d9',
    SUCCESS: '#ccbca3',
};

const MONTHS = [
    'Январь',
    'Февраль',
    'Март',
    'Апрель',
    'Май',
    'Июнь',
    'Июль',
    'Август',
    'Сентябрь',
    'Октябрь',
    'Ноябрь',
    'Декабрь',
];

function convertToRussianCurrency(number) {
    const units = ['', 'тыс.', 'млн.', 'млрд.', 'трлн.']; // Массив для
                                                          // постфиксов
    const mobUnits = ['', 'т.', 'м.', 'млрд.', 'трлн.'];
    const base = 1000; // Базовое число

    if (number < base) {
        return number.toString(); // Возвращаем число меньше базового без
                                  // изменений
    }

    const exponent = Math.floor(Math.log10(number) / Math.log10(base)); // Определяем
                                                                        // показатель
                                                                        // степени

    let postfix = units[exponent]; // Получаем соответствующий постфикс
    if (window.innerWidth <= 576) {
        postfix = mobUnits[exponent];
    }

    const convertedNumber = number / Math.pow(base, exponent); // Конвертируем
                                                               // число

    return convertedNumber.toFixed(0) + ' ' + postfix; // Конвертированное
                                                       // число с округлением
                                                       // до 1 знака после
                                                       // запятой и добавленный
                                                       // постфикс
}

// Analytic Page

const htmlLegendPlugin = {
    id: 'htmlLegend',
    afterUpdate(chart, args, options) {
        const ul = getOrCreateLegendList(chart, options.containerID);

        // Remove old legend items
        while (ul.firstChild) {
            ul.firstChild.remove();
        }

        // Reuse the built-in legendItems generator
        const items = chart.options.plugins.legend.labels.generateLabels(chart);

        items.forEach(item => {
            const li = document.createElement('li');
            li.classList.add('analytic-chart-legend');

            if (item.hidden) {
                li.classList.add('analytic-chart-legend_hidden');
            } else {
                li.classList.remove('analytic-chart-legend_hidden');
            }

            li.onclick = () => {
                const {type} = chart.config;
                if (type === 'pie' || type === 'doughnut') {
                    // Pie and doughnut charts only have a single dataset and
                    // visibility is per item
                    chart.toggleDataVisibility(item.index);
                } else {
                    chart.setDatasetVisibility(item.datasetIndex,
                        !chart.isDatasetVisible(item.datasetIndex));
                }
                chart.update();
            };

            // Color box
            const boxSpan = document.createElement('span');
            boxSpan.classList.add('analytic-chart-legend__color');
            boxSpan.style.background = item.fillStyle;

            // Text
            const textContainer = document.createElement('p');
            textContainer.classList.add('analytic-chart-legend__text');
            textContainer.style.color = item.fontColor;

            const text = document.createTextNode(item.text);
            textContainer.appendChild(text);

            li.appendChild(boxSpan);
            li.appendChild(textContainer);
            ul.appendChild(li);
        });
    },
};

const getOrCreateTooltip = (chart) => {
    let tooltipEl = chart.canvas.parentNode.querySelector('div');

    if (!tooltipEl) {
        tooltipEl = document.createElement('div');
        tooltipEl.classList.add('analytic-tooltip');
        tooltipEl.style.opacity = 1;
        tooltipEl.style.pointerEvents = 'none';
        tooltipEl.style.position = 'absolute';
        tooltipEl.style.transform = 'translate(15%, -10%)';
        tooltipEl.style.transition = 'all .1s ease';

        const table = document.createElement('table');
        table.style.margin = '0px';

        tooltipEl.appendChild(table);
        chart.canvas.parentNode.appendChild(tooltipEl);
    }

    return tooltipEl;
};

const externalTooltipHandler = (context) => {
    // Tooltip Element
    const {
        chart,
        tooltip,
    } = context;
    const tooltipEl = getOrCreateTooltip(chart);

    // Hide if no tooltip
    if (tooltip.opacity === 0) {
        tooltipEl.style.opacity = 0;
        return;
    }

    // Set Text
    if (tooltip.body) {
        const titleLines = tooltip.title || [];
        const bodyLines = tooltip.body.map(b => b.lines);

        const tableHead = document.createElement('thead');

        titleLines.forEach((title, i) => {
            const div = document.createElement('div');
            div.classList.add('analytic-tooltip__top');
            const colors = tooltip.labelColors[i];

            const span = document.createElement('span');
            span.classList.add('analytic-tooltip__badge');
            span.style.background = colors.backgroundColor;
            span.style.borderColor = colors.borderColor;

            const tr = document.createElement('tr');
            tr.style.borderWidth = 0;

            const th = document.createElement('th');
            th.style.borderWidth = 0;
            const textEl = document.createElement('span');
            textEl.classList.add('analytic-tooltip__top-text');
            textEl.textContent = tooltip.dataPoints[0].dataset.label;

            th.appendChild(span);
            div.appendChild(span);
            div.appendChild(textEl);

            th.appendChild(div);

            tr.appendChild(th);
            tableHead.appendChild(tr);
        });

        const tableBody = document.createElement('tbody');

        tableBody.innerHTML = `
                <tr style="background-color: inherit; border-width: 0">
                    <td>Заказов: <strong>${tooltip.dataPoints[0].raw.orders}</strong></td>
                </tr>
                <tr style="background-color: inherit; border-width: 0">
                    <td>Товаров: <strong>${tooltip.dataPoints[0].raw.items}</strong></td>
                </tr>
                <tr style="background-color: inherit; border-width: 0">
                    <td>Сумма: <strong>${tooltip.dataPoints[0].raw.price.toLocaleString(
            'ru-RU')} ₽</strong></td>
                </tr>
            `;

        // bodyLines.forEach((body, i) => {
        //
        //
        //     const tr = document.createElement('tr');
        //     tr.style.backgroundColor = 'inherit';
        //     tr.style.borderWidth = 0;
        //
        //     const td = document.createElement('td');
        //     td.style.borderWidth = 0;
        //
        //     const text = document.createTextNode(body);
        //
        //     // td.appendChild(span);
        //     td.appendChild(text);
        //     tr.appendChild(td);
        //     tableBody.appendChild(tr);
        // });

        const tableRoot = tooltipEl.querySelector('table');

        // Remove old children
        while (tableRoot.firstChild) {
            tableRoot.firstChild.remove();
        }

        // Add new children
        tableRoot.appendChild(tableHead);
        tableRoot.appendChild(tableBody);
    }

    const {
        offsetLeft: positionX,
        offsetTop: positionY,
    } = chart.canvas;

    // Display, position, and set styles for font
    tooltipEl.style.opacity = 1;
    tooltipEl.style.left = positionX + tooltip.caretX + 'px';
    tooltipEl.style.top = positionY + tooltip.caretY + 'px';
    tooltipEl.style.font = tooltip.options.bodyFont.string;
    // tooltipEl.style.padding = tooltip.options.padding + 'px ' +
    // tooltip.options.padding + 'px';
};

const getOrCreateLegendList = (chart, id) => {
    const legendContainer = document.getElementById(id);
    let listContainer = legendContainer.querySelector('ul');

    if (!listContainer) {
        listContainer = document.createElement('ul');
        listContainer.style.display = 'flex';
        listContainer.style.flexDirection = 'row';
        listContainer.style.margin = 0;
        listContainer.style.padding = 0;

        legendContainer.appendChild(listContainer);
    }

    return listContainer;
};

function analytics() {
    const analytic = document.querySelector('.analytics');
    const form = analytic.querySelector('.analytics__content');
    const ctxWrapper = analytic.querySelector('.analytic-chart__canvas');
    const ctx = analytic.querySelector('canvas');
    const analyticChartTitle = analytic.querySelector('.analytic-chart__title');
    const defaultChartTitle = analyticChartTitle.textContent;
    const analyticButtonCompare = analytic.querySelector(
        '.analytic-chart__btn-compare.js--analytic-compare');
    const analyticButtonRemoveCompare = analytic.querySelector(
        '.analytic-chart__btn-compare.js--analytic-remove-compare');
    const analyticChartDropdown = analytic.querySelector(
        '.analytic-chart__dropdown');
    const analyticStatusBlock = analytic.querySelector(
        '.analytic-chart-legends__filter');
    const inputCompare = form.querySelector('input[name="comparison"]');


    document.body.classList.add('analytic-page');

    Chart.defaults.font.family = 'Inter';
    Chart.defaults.font.weight = 600;
    Chart.defaults.color = '#919599';
    Chart.Tooltip.positioners.bottom = function (items) {
        const pos = components.Tooltip.positioners.average(items);

        // Happens when nothing is found
        if (pos === false) {
            return false;
        }

        const chart = this.chart;

        return {
            x: pos.x,
            y: chart.chartArea.bottom,
            xAlign: 'center',
            yAlign: 'bottom',
        };
    };

    // const data = {
    //     labels: [
    //         1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19,
    //     ],
    //     datasets: [
    //         {
    //             label: 'Октябрь',
    //             data: [
    //                 {
    //                     orders: 14,
    //                     items: 15,
    //                     price: 1000000,
    //                 }, {
    //                     orders: 10,
    //                     items: 25,
    //                     price: 2000000,
    //                 }, {
    //                     orders: 11,
    //                     items: 25,
    //                     price: 500000,
    //                 },
    //             ],
    //             backgroundColor: COLORS.GRAY_LIGHT,
    //             borderRadius: 8,
    //         }, {
    //             label: 'Ноябрь',
    //             data: [
    //                 {
    //                     orders: 25,
    //                     items: 25,
    //                     price: 1025230,
    //                 }, {
    //                     orders: 13,
    //                     items: 25,
    //                     price: 1235235,
    //                 }, {
    //                     orders: 12,
    //                     items: 25,
    //                     price: 2023423,
    //                 },
    //             ],
    //             backgroundColor: COLORS.GRAY,
    //             borderRadius: 8,
    //         },
    //     ],
    // };

    const data = JSON.parse(ctxWrapper.dataset.chart);

    const chart = new Chart(ctx, {
        type: 'bar',
        data: data,
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                htmlLegend: {
                    containerID: 'analytic-chart-legend',
                },
                legend: {
                    position: 'bottom',
                    display: false,
                },
                tooltip: {
                    enabled: false,
                    external: externalTooltipHandler,
                },
            },
            scales: {
                x: {
                    // type: 'time',
                    // time: {
                    //   unit: 'day'
                    // },
                    beginAtZero: true,
                    stacked: !inputCompare.value,
                    grid: {
                        display: false,
                        drawBorder: false,
                    },
                    ticks: {
                        maxTicksLimit: 7,
                    },
                },
                y: {
                    // Ставить true если не сравнение
                    stacked: !inputCompare.value,
                    grid: {
                        lineWidth: 2,
                        drawTicks: true,
                    },
                    border: {
                        display: false,
                    },
                    ticks: {
                        maxTicksLimit: 6,
                    },
                    afterTickToLabelConversion: function (chart) {
                        chart.ticks.map((tick) => {
                            tick.label = `${convertToRussianCurrency(
                                tick.value)} ${window.innerWidth <= 576
                                ? ''
                                : '₽'}`;
                        });
                    },
                },
            },
            parsing: {
                xAxisKey: 'price',
                yAxisKey: 'price',
            },
        },
        plugins: [htmlLegendPlugin],
    });

    form.querySelectorAll('.form-control__dropdown-item').forEach(item => {
        item.addEventListener('click', () => {
            setTimeout(() => {
                form.submit();
            }, 0);
        });
    });

    if (analyticButtonCompare)
        analyticButtonCompare.addEventListener('click', () => {
            inputCompare.value = 1;
            form.submit();
        });

    if (analyticButtonRemoveCompare)
        analyticButtonRemoveCompare.addEventListener('click', () => {
            inputCompare.value = 0;
            form.submit();
        });

    if (inputCompare.value) {
        analytic.classList.add('analytics_comparison');
    }

    // document.querySelectorAll('.js--analytic-remove-compare').forEach(trigger
    // => {  trigger.addEventListener('click', () => {
    // analytic.classList.remove('analytics_comparison');
    // analyticChartTitle.textContent = defaultChartTitle; }) });
    // document.querySelectorAll('.js--analytic-compare').forEach(trigger => {
    // trigger.addEventListener('click', () => {
    // analytic.classList.add('analytics_comparison');
    // analyticChartTitle.textContent = 'Сравнение этого месяца и предыдущего';
    // }) });

}

function analyticInit() {
    analytics();
}

window.addEventListener('DOMContentLoaded', analyticInit);