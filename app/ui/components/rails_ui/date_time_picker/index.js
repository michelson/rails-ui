// date_time_input_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["day", "month", "year", "hour", "minute", "dayPeriod"];

  connect() {
    this.initializeSegments();
  }

  initializeSegments() {
    // Initialize segments to set placeholder values or empty defaults
    if (this.hasDayTarget) this.dayTarget.textContent = "––";
    if (this.hasMonthTarget) this.monthTarget.textContent = "––";
    if (this.hasYearTarget) this.yearTarget.textContent = "––";
    if (this.hasHourTarget) this.hourTarget.textContent = "––";
    if (this.hasMinuteTarget) this.minuteTarget.textContent = "––";
    if (this.hasDayPeriodTarget) this.dayPeriodTarget.textContent = "AM";
  }

  incrementSegment(event) {
    const segment = event.target;
    if (segment.dataset.type === "hour") {
      this.adjustHour(1);
    } else if (segment.dataset.type === "minute") {
      this.adjustMinute(1);
    } else if (segment.dataset.type === "dayPeriod") {
      this.toggleDayPeriod();
    } else if (segment.dataset.type === "day") {
      this.adjustDay(1);
    } else if (segment.dataset.type === "month") {
      this.adjustMonth(1);
    } else if (segment.dataset.type === "year") {
      this.adjustYear(1);
    }
  }

  decrementSegment(event) {
    const segment = event.target;
    if (segment.dataset.type === "hour") {
      this.adjustHour(-1);
    } else if (segment.dataset.type === "minute") {
      this.adjustMinute(-1);
    } else if (segment.dataset.type === "dayPeriod") {
      this.toggleDayPeriod();
    } else if (segment.dataset.type === "day") {
      this.adjustDay(-1);
    } else if (segment.dataset.type === "month") {
      this.adjustMonth(-1);
    } else if (segment.dataset.type === "year") {
      this.adjustYear(-1);
    }
  }

  adjustDay(delta) {
    let currentDay = parseInt(this.dayTarget.textContent) || 1;
    currentDay += delta;
    if (currentDay > 31) {
      currentDay = 1;
    } else if (currentDay < 1) {
      currentDay = 31;
    }
    this.dayTarget.textContent = currentDay.toString().padStart(2, '0');
  }

  adjustMonth(delta) {
    let currentMonth = parseInt(this.monthTarget.textContent) || 1;
    currentMonth += delta;
    if (currentMonth > 12) {
      currentMonth = 1;
    } else if (currentMonth < 1) {
      currentMonth = 12;
    }
    this.monthTarget.textContent = currentMonth.toString().padStart(2, '0');
  }

  adjustYear(delta) {
    let currentYear = parseInt(this.yearTarget.textContent) || new Date().getFullYear();
    currentYear += delta;
    this.yearTarget.textContent = currentYear.toString();
  }

  adjustHour(delta) {
    let currentHour = parseInt(this.hourTarget.textContent) || 1;
    currentHour += delta;
    if (currentHour > 12) {
      currentHour = 1;
    } else if (currentHour < 1) {
      currentHour = 12;
    }
    this.hourTarget.textContent = currentHour.toString().padStart(2, '0');
  }

  adjustMinute(delta) {
    let currentMinute = parseInt(this.minuteTarget.textContent) || 0;
    currentMinute += delta;
    if (currentMinute >= 60) {
      currentMinute = 0;
    } else if (currentMinute < 0) {
      currentMinute = 59;
    }
    this.minuteTarget.textContent = currentMinute.toString().padStart(2, '0');
  }

  toggleDayPeriod() {
    this.dayPeriodTarget.textContent = this.dayPeriodTarget.textContent === "AM" ? "PM" : "AM";
  }

  focusSegment(event) {
    this.clearFocus();
    const segment = event.target;
    segment.dataset.focused = true;
  }

  blurSegment(event) {
    const segment = event.target;
    delete segment.dataset.focused;
  }

  clearFocus() {
    if (this.hasDayTarget) delete this.dayTarget.dataset.focused;
    if (this.hasMonthTarget) delete this.monthTarget.dataset.focused;
    if (this.hasYearTarget) delete this.yearTarget.dataset.focused;
    if (this.hasHourTarget) delete this.hourTarget.dataset.focused;
    if (this.hasMinuteTarget) delete this.minuteTarget.dataset.focused;
    if (this.hasDayPeriodTarget) delete this.dayPeriodTarget.dataset.focused;
  }
}
