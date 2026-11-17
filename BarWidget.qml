import QtQuick
import qs.Commons
import qs.Ui

// Bar buttons for notification history and the clipboard manager. Each one
// runs the same shell IPC as the matching Omarchy keybinding
// (Super+Shift+Alt+Comma and Super+Ctrl+V), so they behave exactly the same.
BarWidget {
  id: root
  moduleName: "io.github.swaranga.history-buttons"

  // The buttons this instance shows. Unset or empty shows both; naming one
  // lets a second instance elsewhere on the bar carry the other.
  readonly property var chosen: {
    var value = setting("buttons", [])
    return Array.isArray(value) ? value : []
  }
  readonly property bool showNotifications: chosen.length === 0 || chosen.indexOf("notifications") !== -1
  readonly property bool showClipboard: chosen.length === 0 || chosen.indexOf("clipboard") !== -1

  visible: showNotifications || showClipboard
  implicitWidth: buttons.implicitWidth
  implicitHeight: buttons.implicitHeight

  Translations { id: strings; directory: Qt.resolvedUrl("i18n") }

  function run(command) {
    if (root.bar) root.bar.run(command)
  }

  // Hide the cards when any are on screen, otherwise bring the recent ones
  // back, so a second click undoes the first. Asking the shell on every click
  // stays right after cards time out or are dismissed some other way.
  readonly property string toggleHistory: "if [ \"$(omarchy-shell notifications count)\" -gt 0 ] 2>/dev/null; "
    + "then omarchy-shell notifications dismissAll; "
    + "else omarchy-shell notifications showHistory; fi"

  Grid {
    id: buttons
    anchors.centerIn: parent
    columns: root.vertical ? 1 : 2
    spacing: 0

    BarIconButton {
      bar: root.bar
      visible: root.showNotifications
      text: "\u{f009a}"
      tooltipText: strings.t("notifications.tooltip")
      onPressed: function(button) {
        if (button === Qt.LeftButton) root.run(root.toggleHistory)
        else if (button === Qt.RightButton) root.run("omarchy-shell notifications dismissAll")
      }
    }

    BarIconButton {
      bar: root.bar
      visible: root.showClipboard
      text: "\u{f0147}"
      tooltipText: strings.t("clipboard.tooltip")
      onPressed: function(button) {
        if (button === Qt.LeftButton) root.run("omarchy-shell shell toggle omarchy.clipboard")
      }
    }
  }
}
