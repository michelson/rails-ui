import { Controller } from "@hotwired/stimulus";
import Chart from 'chart.js/auto';


export default class extends Controller {
  static targets = ["canvas"];
  static values = {
    type: {type: String, value: "line" },
    data: Object,
    config: {type: Object, value: {} },
  };

  connect() {
    const element = this.hasCanvasTarget ? this.canvasTarget : this.element;

    /*this.chart = new Chart(element.getContext("2d"), {
      type: this.typeValue,
      data: this.chartData,
      options: this.chartOptions,
    });*/

    console.log(this.typeValue, this.dataValue, this.configValue)

    this.chart = new Chart(element.getContext("2d"), {
        type: this.typeValue,
        data: this.dataValue,
        options: this.configValue,
    });
  }

  disconnect() {
    if (this.chart) {
      this.chart.destroy();
      this.chart = undefined;
    }
  }

  get hasCanvasTarget() {
    return this.canvasTarget !== undefined;
  }
}
