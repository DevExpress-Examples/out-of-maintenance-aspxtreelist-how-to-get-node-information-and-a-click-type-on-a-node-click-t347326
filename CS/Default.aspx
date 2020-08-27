<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register Assembly="DevExpress.Web.ASPxTreeList.v15.2, Version=15.2.20.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxTreeList" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v15.2, Version=15.2.20.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">
        var isPressed = false;
        var doProcessClick;
        var nodeKey;
        function onInit(s, e) {
            ASPxClientUtils.AttachEventToElement(
                window.document,
                "keydown",
                function (evt) {
                    if (evt.keyCode == 18) // ALT
                        isPressed = true;
                }
            );
            ASPxClientUtils.AttachEventToElement(
               window.document,
               "keyup",
               function (evt) {
                   if (evt.keyCode == 18) // ALT
                       isPressed = false;
               }
           );
        }
        function onClick(s, e) {
            doProcessClick = true;
            nodeKey = e.nodeKey;
            window.setTimeout(function ProcessClick() {
                if (doProcessClick) {
                    s.GetNodeValues(nodeKey, "LastName", ShowNodeClick)
                }
            }, 200);
        }

        function onDblClick(s, e) {
            doProcessClick = false;
            s.GetNodeValues(e.nodeKey, "LastName", ShowNodeDblClick)
        }
        function ShowNodeDblClick(value) {
            alert("DblClick - " + value);
        }
        function ShowNodeClick(value) {
            if (isPressed)
                alert("ALT + Click - " + value);
            else
                alert("Click - " + value);
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <dx:ASPxTreeList ID="tree" runat="server" AutoGenerateColumns="False" DataSourceID="ads"
                KeyFieldName="EmployeeID" ParentFieldName="ReportsTo">
                <Columns>
                    <dx:TreeListTextColumn FieldName="LastName" />
                    <dx:TreeListTextColumn FieldName="FirstName" />
                    <dx:TreeListTextColumn FieldName="ReportsTo" Visible="false" />
                    <dx:TreeListCommandColumn />
                </Columns>
                <SettingsBehavior AllowFocusedNode="true" />
                <ClientSideEvents Init="onInit" NodeClick="onClick" NodeDblClick="onDblClick" />
            </dx:ASPxTreeList>
            <asp:AccessDataSource ID="ads" runat="server" DataFile="~/App_Data/nwind.mdb" SelectCommand="SELECT [EmployeeID], [LastName], [FirstName], [ReportsTo] FROM [Employees]"></asp:AccessDataSource>
        </div>
    </form>
</body>
</html>
