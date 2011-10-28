﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<MvcInstaller.Settings.InstallerConfig>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Index
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        MVC Site Installer</h2>
    <p>For more information on this installer, please visit <a href="http://mvcinstaller.codeplex.com" target="_blank">http://mvcinstaller.codeplex.com</a>.</p>
    <p>The data below is the information from your installer.config file that will be used to install your application.</p>

    <fieldset>
        <legend>Database settings</legend>
        <p>The database and db user needs to be created prior to running the installer!</p>
        
        <div class="fieldwrapper">
            <div class="installer-label">
                Database:</div>
            <div class="display-field">
                <%= Model.Database.InitialCatalog %></div>
        </div>
        <div class="fieldwrapper">
            <div class="installer-label">
                Data Source:</div>
            <div class="display-field">
                <%= Model.Database.DataSource %></div>
        </div>
        <% if (Model.Database.UseTrustedConnection)
           { %>
        <div class="fieldwrapper">
            <div class="installer-label">Trusted Connection:</div>
            <div class="display-field">True</div>
        </div>
        <%}
           else
           { %>
        <div class="fieldwrapper">
            <div class="installer-label">
                Username:</div>
            <div class="display-field">
                <%= Model.Database.UserName%></div>
        </div>
        <div class="fieldwrapper">
            <div class="installer-label">
                Password:</div>
            <div class="display-field">
                <%= Model.Database.Password%></div>
        </div>
        <%} %>
    </fieldset>
    <fieldset>
        <legend>Membership settings</legend>
        <p>These are the Roles and Users to be created by the installer.</p>
        <% foreach (var role in Model.Membership.Roles)
           {%>
        <div class="fieldwrapper">
            <div class="installer-label">
                Role:</div>
            <div class="display-field">
                <%= role.Name %></div>
        </div>
        <% foreach (var user in role.Users)
           {%>
        <div class="fieldwrapperindented">
            <div class="installer-label">
                User in role:</div>
            <div class="display-field">
                <%= user.UserName %>:<%=user.Password %></div>
        </div>
        <%} %>
        <%} %>
    </fieldset>
    <div id="response"></div>
    <button id="runprocess">Install</button>
    <span id="loader" style="display: none;">
        <img src="/content/ajax-loader.gif" alt="Processing... please wait!" />&nbsp;Processing... please wait!
    </span>

    <script type="text/javascript">

        $(function() {
            var loader = $("#loader");
            var responseDiv = $("#response");
            var button = $("#runprocess");

            $("#runprocess").live("click", function() {
                button.hide();
                loader.show();

                $.ajax(
                {
                    url: '<%= Url.Action("Run", "Install") %>',
                    datatype: 'json',
                    type: 'POST',
                    success: OnSuccess,
                    error: OnError
                });
            });

            var resp = $("#response");
            function OnSuccess(data) {
                loader.hide();
                var msg = data.Message;
                if (msg == "The installer completed successfully!") {
                    msg += " <a href=\"/Account/LogOn\">Log On</a>";
                } else {
                    button.show();
                }
                resp.html(msg);
            }

            function OnError(data) {
                loader.hide();
                resp.html(data.Message);
                button.show();
            }
        });
    
    </script>

</asp:Content>