import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.0
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.impl 2.15
import QtQuick.Controls.Universal 2.15

import "../../Components"
import App 1.0
import Dex.Themes 1.0 as Dex

DefaultComboBox
{
    id: control

    mainBorderColor: Style.getCoinColor(ticker)
    radius: 10

    contentItem: DexComboBoxLine
    {
        id: line
        padding: 10

        Component.onCompleted: portfolio_mdl.portfolioItemDataChanged.connect(forceUpdateDetails)
        Component.onDestruction: portfolio_mdl.portfolioItemDataChanged.disconnect(forceUpdateDetails)

        function forceUpdateDetails()
        {
            console.log("Portfolio item data changed, force-updating the selected ticker details!")
            ++update_count
        }

        property int update_count: 0
        property var prev_details

        details:
        {
            const idx = combo.currentIndex

            if(idx === -1) return prev_details

            // Update count triggers the change for auto-update
            const new_details =
                              {
                update_count:           line.update_count,
                ticker:                 model.data(model.index(idx, 0), 257),
                name:                   model.data(model.index(idx, 0), 259),
                balance:                model.data(model.index(idx, 0), 260),
                main_currency_balance:  model.data(model.index(idx, 0), 261)
            }

            prev_details = new_details

            return new_details
         }
    }

    height: 80

    // Each dropdown item
    delegate: ItemDelegate
    {
        Universal.accent: control.lineHoverColor
        width: control.width
        highlighted: control.highlightedIndex === index
        contentItem: DexComboBoxLine { details: model }
        z: 5
    }

    // Dropdown itself
    popup: Popup
    {
        id: popup

        readonly property double max_height: 450//control.Window.height - bottomMargin - mapToItem(control.Window.contentItem, x, y).y

        width: control.width
        height: Math.min(contentItem.implicitHeight, popup.max_height)
        z: 4
        y: control.height - 1
        bottomMargin: 20
        padding: 1
        rightMargin: 5

        contentItem: ColumnLayout
        {
            anchors.rightMargin: 5

            // Search input
            DefaultTextField
            {
                id: input_coin_filter
                background: Item
                {
                    DefaultRectangle
                    {
                        anchors.fill: parent
                        anchors.rightMargin: 2
                    }
                }

                function reset()
                {
                    text = ""
                    renewIndex()
                }

                placeholderText: qsTr("Search")

                font.pixelSize: 16

                Layout.fillWidth: true
                Layout.leftMargin: 0
                Layout.preferredHeight: 60
                Layout.rightMargin: 2
                Layout.topMargin: Layout.leftMargin

                onTextChanged:
                {
                    ticker_list.setFilterFixedString(text)
                    renewIndex()
                }

                Keys.onDownPressed: control.incrementCurrentIndex()
                Keys.onUpPressed: control.decrementCurrentIndex()
                Keys.onPressed:
                {
                    if (event.key === Qt.Key_Return)
                    {
                        if (control.count > 0) control.currentIndex = 0;
                        popup.close();
                        event.accepted = true;
                    }
                }

                Connections
                {
                    target: popup
                    function onOpened()
                    {
                        input_coin_filter.reset();
                        input_coin_filter.forceActiveFocus();
                    }
                    function onClosed() { input_coin_filter.reset() }
                }
            }
            Item
            {
                Layout.maximumHeight: popup.max_height - 100
                Layout.fillWidth: true
                implicitHeight: popup_list_view.contentHeight + 5
                DefaultListView
                {
                    id: popup_list_view
                     // Scrollbar appears if this extra space is not added
                    model: control.popup.visible ? control.delegateModel : null
                    currentIndex: control.highlightedIndex
                    anchors.fill: parent
                    anchors.rightMargin: 2

                    DefaultMouseArea
                    {
                        anchors.fill: parent
                        acceptedButtons: Qt.NoButton
                    }
                }
            }
        }

        background: DefaultRectangle
        {
            width: parent.width
            y: -5
            height: parent.height + 10
            border.width: 1
            border.color: control.mainBorderColor
        }
    }
}
