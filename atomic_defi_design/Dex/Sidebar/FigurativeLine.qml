import QtQuick 2.12

import "../Components"
import Dex.Themes 1.0 as Dex

// FigurativeLine acts the same as Line but contains a figurative icon on the left of its label
Line
{
    property alias icon: _icon

    DefaultImage
    {
        id: _icon
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 30
        height: 16
    }

    DefaultColorOverlay
    {
        anchors.fill: _icon
        source: _icon
        color: enabled ? Dex.CurrentTheme.foregroundColor : Dex.CurrentTheme.textDisabledColor
    }
}
