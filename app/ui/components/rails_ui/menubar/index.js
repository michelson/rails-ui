// app/javascript/controllers/ui_menubar_controller.js
import { Controller } from "@hotwired/stimulus"
import { computePosition, flip, shift, offset, autoUpdate } from '@floating-ui/dom'

export default class extends Controller {
  static targets = ["menuItem", "submenuTemplate"]

  connect() {
    this.activeSubmenus = new Set()
    this.cleanup = null
    this.submenus = new Map()
    this.hideTimeout = null
    
    document.addEventListener('click', this.handleClick.bind(this))
    document.addEventListener('mouseover', this.handleMouseOver.bind(this))
    document.addEventListener('mouseout', this.handleMouseOut.bind(this))
  }

  disconnect() {
    this.cleanupAllSubmenus()
    document.removeEventListener('click', this.handleClick.bind(this))
    document.removeEventListener('mouseover', this.handleMouseOver.bind(this))
    document.removeEventListener('mouseout', this.handleMouseOut.bind(this))
  }

  handleClick(event) {
    const menuItem = event.target.closest('[data-ui-menubar-item], [data-ui-menubar-submenu-item]')
    if (menuItem) {
      event.stopPropagation()
      if (menuItem.closest('[data-ui-menubar-top-level]') || menuItem.closest('[data-ui-menubar-submenu]')) {
        this.toggleMenu(menuItem)
      }
    } else if (!event.target.closest('[data-ui-menubar-submenu]')) {
      this.closeAllSubmenus()
    }
  }

  handleMouseOver(event) {
    const submenuItem = event.target.closest('[data-ui-menubar-submenu-item]')
    if (submenuItem && submenuItem.closest('[data-ui-menubar-top-level]')) {
      clearTimeout(this.hideTimeout)
      this.showSubmenu(submenuItem)
    }
  }

  handleMouseOut(event) {
    const submenuItem = event.target.closest('[data-ui-menubar-submenu-item]')
    if (submenuItem && submenuItem.closest('[data-ui-menubar-top-level]')) {
      this.hideSubmenuWithDelay(submenuItem)
    }
  }

  toggleMenu(menuItem) {
    const index = menuItem.dataset.uiMenubarItem || menuItem.dataset.uiMenubarSubmenuItem
    const hasSubmenu = menuItem.dataset.hasSubmenu === 'true'

    if (hasSubmenu) {
      if (this.activeSubmenus.has(index)) {
        this.closeSubmenu(this.submenus.get(index))
      } else {
        this.showSubmenu(menuItem)
      }
    } else {
      console.log(`Clicked menu item: ${menuItem.textContent.trim()}`)
      this.closeAllSubmenus()
    }
  }

  showSubmenu(menuItem) {
    const index = menuItem.dataset.uiMenubarItem || menuItem.dataset.uiMenubarSubmenuItem
    const hasSubmenu = menuItem.dataset.hasSubmenu === 'true'

    if (hasSubmenu) {
      // Close sibling submenus
      this.closeSiblingSubmenus(menuItem)

      if (!this.submenus.has(index)) {
        this.createSubmenu(menuItem, index)
      } else {
        this.openSubmenu(menuItem, this.submenus.get(index))
      }
    }
  }

  hideSubmenuWithDelay(menuItem) {
    this.hideTimeout = setTimeout(() => {
      const submenuIndex = menuItem.dataset.uiMenubarItem || menuItem.dataset.uiMenubarSubmenuItem
      if (submenuIndex && this.submenus.has(submenuIndex)) {
        const submenu = this.submenus.get(submenuIndex)
        if (!submenu.contains(document.activeElement)) {
          this.closeSubmenu(submenu)
        }
      }
    }, 300)
  }

  createSubmenu(menuItem, index) {
    const template = this.submenuTemplateTarget
    const submenuContent = template.content.querySelector(`[data-submenu-for="${index}"]`)
    
    if (submenuContent) {
      const submenu = submenuContent.cloneNode(true)
      document.body.appendChild(submenu)
      this.submenus.set(index, submenu)
      this.openSubmenu(menuItem, submenu)
    }
  }

  openSubmenu(menuItem, submenu) {
    menuItem.setAttribute("aria-expanded", "true")
    menuItem.dataset.state = "open"
    submenu.dataset.state = "open"
    submenu.style.display = "block"
    
    const index = menuItem.dataset.uiMenubarItem || menuItem.dataset.uiMenubarSubmenuItem
    this.activeSubmenus.add(index)

    this.cleanup = autoUpdate(menuItem, submenu, () => {
      this.positionSubmenu(menuItem, submenu)
    })
  }

  closeSubmenu(submenu) {
    const index = submenu.dataset.submenuFor
    const menuItem = document.querySelector(`[data-ui-menubar-item="${index}"], [data-ui-menubar-submenu-item="${index}"]`)
    
    if (menuItem) {
      menuItem.setAttribute("aria-expanded", "false")
      menuItem.dataset.state = "closed"
    }
    submenu.dataset.state = "closed"
    submenu.style.display = "none"
    
    this.activeSubmenus.delete(index)
    
    if (this.cleanup) {
      this.cleanup()
      this.cleanup = null
    }

    // Close all child submenus
    submenu.querySelectorAll('[data-ui-menubar-submenu-item]').forEach(childItem => {
      const childIndex = childItem.dataset.uiMenubarSubmenuItem
      if (this.submenus.has(childIndex)) {
        this.closeSubmenu(this.submenus.get(childIndex))
      }
    })
  }

  closeSiblingSubmenus(menuItem) {
    const parentSubmenu = menuItem.closest('[data-ui-menubar-submenu]')
    const siblingItems = parentSubmenu 
      ? parentSubmenu.querySelectorAll(':scope > [data-ui-menubar-submenu-item]')
      : this.menuItemTargets

    siblingItems.forEach(sibling => {
      if (sibling !== menuItem) {
        const siblingIndex = sibling.dataset.uiMenubarItem || sibling.dataset.uiMenubarSubmenuItem
        if (this.activeSubmenus.has(siblingIndex)) {
          this.closeSubmenu(this.submenus.get(siblingIndex))
        }
      }
    })
  }

  closeAllSubmenus() {
    this.activeSubmenus.forEach(index => {
      if (this.submenus.has(index)) {
        this.closeSubmenu(this.submenus.get(index))
      }
    })
  }

  cleanupAllSubmenus() {
    this.submenus.forEach(submenu => {
      if (submenu.parentNode) {
        submenu.parentNode.removeChild(submenu)
      }
    })
    this.submenus.clear()
    this.activeSubmenus.clear()
    if (this.cleanup) {
      this.cleanup()
      this.cleanup = null
    }
  }

  positionSubmenu(menuItem, submenu) {
    const parentSubmenu = menuItem.closest('[data-ui-menubar-submenu]')
    const placement = parentSubmenu ? 'right-start' : 'bottom-start'

    computePosition(menuItem, submenu, {
      placement: placement,
      middleware: [
        offset(4),
        flip(),
        shift({padding: 5})
      ]
    }).then(({x, y}) => {
      Object.assign(submenu.style, {
        position: 'absolute',
        left: `${x}px`,
        top: `${y}px`,
      })
    })
  }
}