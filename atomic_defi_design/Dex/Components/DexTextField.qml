import QtQuick 2.15
import QtQuick.Controls 2.15
import "../Constants"
import App 1.0
import Dex.Themes 1.0 as Dex

TextField
{
    id: text_field

    property alias left_text: left_text.text_value
    property alias right_text: right_text.text_value

    font: DexTypo.body2
    placeholderTextColor: Dex.CurrentTheme.textPlaceholderColor
    selectedTextColor: Dex.CurrentTheme.textSelectedColor
    selectionColor: Dex.CurrentTheme.textSelectionColor
    color: enabled ? Dex.CurrentTheme.foregroundColor : Dex.CurrentTheme.textDisabledColor

    Behavior on color
    {
        ColorAnimation
        {
            duration: Style.animationDuration
        }
    }
    Behavior on placeholderTextColor
    {
        ColorAnimation
        {
            duration: Style.animationDuration
        }
    }

    // Right click Context Menu
    selectByMouse: true
    persistentSelection: true

    background: DexRectangle
    {
        color: Dex.CurrentTheme.accentColor
        opacity: .4
        radius: height / 2
        anchors.fill: parent
    }

    leftPadding: Math.max(0, left_text.width + 20)
    rightPadding: Math.max(0, right_text.width + 20)
    topPadding: 7

    RightClickMenu {}

    DefaultText
    {
        id: left_text
        visible: text_value !== ""
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter

        font.pixelSize: text_field.font.pixelSize
    }

    DefaultText
    {
        id: right_text
        visible: text_value !== ""
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.verticalCenter: parent.verticalCenter

        font.pixelSize: text_field.font.pixelSize
    }
}
