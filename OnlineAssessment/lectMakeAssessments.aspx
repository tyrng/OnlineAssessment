﻿<%@ Page Language="C#" MasterPageFile="~/assessment.Master" AutoEventWireup="true" CodeBehind="lectMakeAssessments.aspx.cs" Inherits="OnlineAssessment.lectMakeAssessments" %>
<%--<%@ register TagPrefix="lectTreeView" TagName="Head" Src="~/lectTreeView.ascx" %>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<%--    <lectTreeView:Head ID="ctrlLecturerTreeView" runat="server" />--%>
    <div style="width: 70%; margin-left: 15%; margin-top: 5%;">
        <h2>Create Assessment</h2>
        <table class="table table-bordered table table-hover">
            <tr>
                <td style =" width: 30%">Assessment Name:</td>
                <td>
                    <asp:TextBox ID="txtName" runat="server" MaxLength="100"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" id="validate1" ControlToValidate="txtName" ErrorMessage="Required field!"  ></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style3">Assessment Type
                </td>
                <td class="auto-style3">

                    <asp:RadioButtonList ID="rblAssessType" runat="server" AutoPostBack="True">
                        <asp:ListItem Value="Public" Text="Public" Selected="True"></asp:ListItem>
                        <asp:ListItem Value="Private" Text="Private"></asp:ListItem>
                    </asp:RadioButtonList>

                    <asp:Label ID="subjectDisplay" runat="server" Text="Subject:" Visible="false"></asp:Label>
                    <asp:DropDownList ID="ddlSubject" runat="server" AppendDataBoundItems="True"
                        DataSourceID="SqlDataSource1" DataTextField="SubjectList" DataValueField="subjectID" AutoPostBack="true">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT S.subjectID, (subjectCode + ' ' + subjectName) AS SubjectList FROM Subject S, enrollLecturer EL, Lecture L
WHERE S.subjectID = EL.subjectID AND L.lecID = EL.lecID AND EL.lecID = @userID">
                        <SelectParameters>
                            <asp:SessionParameter Name="userID" SessionField="userID" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:Label ID="error2" runat="server"></asp:Label>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlSubject"></asp:RequiredFieldValidator>
                </td>

            </tr>
            <tr>
                <td class="auto-style4">Question Type
                </td>
                <td class="auto-style4">
                    <asp:RadioButtonList ID="rblQuestType" runat="server">
                        <asp:ListItem Value="MCQ" Selected="True">MCQ</asp:ListItem>
                        <asp:ListItem Value="Subjective">Subjective</asp:ListItem>
                    </asp:RadioButtonList>
                    <br />
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <asp:Button ID="btnAdd" runat="server" Text="Add" OnClick="btnAdd_Click" class="btn btn-primary w3-hover-opacity"
                        OnClientClick="return confirm('Confirm add assessment?');" />
                    <asp:Button ID="btnReset" runat="server" Text="Reset" OnClick="btnReset_Click" class="btn btn-default w3-hover-opacity"/>
                &nbsp;&nbsp;&nbsp;
                    <asp:Label ID="error1" runat="server"></asp:Label>
                </td>
            </tr>
        </table>
    </div>

</asp:Content>


