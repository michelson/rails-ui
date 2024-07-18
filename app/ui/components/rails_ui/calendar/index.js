import "./index.css"

// app/javascript/controllers/ui_calendar_controller.js
import { Controller } from "@hotwired/stimulus"
import { format, addMonths, startOfMonth, endOfMonth, eachDayOfInterval, isSameMonth, isToday, isSameDay, startOfWeek, endOfWeek } from "date-fns"

export default class extends Controller {
  static targets = ["title", "calendar", "dayTemplate", "input"]
  static values = {
    format: String,
    viewDate: String,
    selectedDate: { type: String, default: null },
    inputId: String
  }

  connect() {
    this.viewDate = new Date(this.viewDateValue)
    this.selectedDate = this.selectedDateValue ? new Date(this.selectedDateValue) : null
    this.renderCalendar()
  }

  renderCalendar() {
    this.titleTarget.textContent = format(this.viewDate, "MMMM yyyy")
    const start = startOfWeek(startOfMonth(this.viewDate))
    const end = endOfWeek(endOfMonth(this.viewDate))
    const days = eachDayOfInterval({ start, end })

    const calendarContainer = this.calendarTarget
    // Clear existing day elements, but keep the weekday headers
    const weekdayHeaders = calendarContainer.querySelectorAll('div:nth-child(-n+7)')
    calendarContainer.innerHTML = ''
    weekdayHeaders.forEach(header => calendarContainer.appendChild(header))

    days.forEach(day => {
      const dayElement = this.createDayElement(day)
      calendarContainer.appendChild(dayElement)
    })

    this.updateInput()
  }

  createDayElement(day) {
    const template = this.dayTemplateTarget.content.cloneNode(true)
    const button = template.querySelector("button")
    
    button.textContent = format(day, "d")
    button.dataset.day = day.toISOString()

    let buttonClass = "hover:bg-accent hover:text-accent-foreground"
    
    if (!isSameMonth(day, this.viewDate)) {
      buttonClass += " text-muted-foreground"
    } else if (isToday(day)) {
      buttonClass += " bg-accent text-accent-foreground"
    }

    if (this.selectedDate && isSameDay(day, this.selectedDate)) {
      buttonClass += " bg-primary text-primary-foreground"
    }

    button.className = button.className.replace("{{buttonClass}}", buttonClass)
    
    return template
  }

  prevMonth() {
    this.viewDate = addMonths(this.viewDate, -1)
    this.renderCalendar()
  }

  nextMonth() {
    this.viewDate = addMonths(this.viewDate, 1)
    this.renderCalendar()
  }

  selectDay(event) {
    const selectedDay = new Date(event.currentTarget.dataset.day)
    this.selectedDate = selectedDay
    this.selectedDateValue = selectedDay.toISOString()
    this.renderCalendar()
  }

  updateInput() {
    const inputElement = document.getElementById(this.inputIdValue)
    if (inputElement && this.selectedDate) {
      inputElement.value = format(this.selectedDate, this.formatValue)
    }
  }
}