﻿<%@ Page Language="C#" MasterPageFile="~/Menu.Master" AutoEventWireup="true" CodeBehind="lecCreateAssess.aspx.cs" Inherits="OnlineAssessment.lecCreateAssess" %>
<%--<%@ Register TagPrefix="LecturerTreeView" TagName="Head" Src="~/lecturerTreeView.ascx" %>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<%--    <LecturerTreeView:Head ID="ctrlLecturerTreeView" runat="server" />--%>
    <div>
        <h2>Create Assessment</h2>
        <table class="alt">
            <tr>
                <td>Assessment Name:</td>
                <td>
                    <asp:TextBox ID="txtName" runat="server" MaxLength="100"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style3">Assessment Type
                </td>
                <td class="auto-style3">

                    <asp:RadioButtonList ID="rblAssessType" runat="server" AutoPostBack="true">
                        <asp:ListItem Value="Public" Text="Public"></asp:ListItem>
                        <asp:ListItem Value="Private" Text="Private"></asp:ListItem>
                    </asp:RadioButtonList>

                    <asp:Label ID="subjectDisplay" runat="server" Text="Subject:" Visible="false"></asp:Label>
                    <asp:DropDownList ID="ddlSubject" runat="server" Visible="False" AppendDataBoundItems="True"
                        DataSourceID="SqlDataSource1" DataTextField="SubjectList" DataValueField="subjectID" AutoPostBack="true">
                        <asp:ListItem Selected="True" Value="0" Text="--Select A Subject--"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT EL.subjectID, (subjectCode + ' ' + subjectName) AS SubjectList FROM Subject S, EnrollLecturer EL, Lecture L
WHERE S.subjectID = EL.subjectID AND L.lecID = EL.lecID AND EL.lecID = @userID">
                        <SelectParameters>
                            <asp:SessionParameter Name="userID" SessionField="userID" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>

            </tr>
            <tr>
                <td class="auto-style4">Question Type
                </td>
                <td class="auto-style4">
                    <asp:RadioButtonList ID="rblQuestType" runat="server">
                        <asp:ListItem Value="MCQ">MCQ</asp:ListItem>
                        <asp:ListItem Value="Subjective">Subjective</asp:ListItem>
                    </asp:RadioButtonList>
                    <br />
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <asp:Button ID="btnAdd" runat="server" Text="Add" OnClick="btnAdd_Click"
                        OnClientClick="return confirm('Confirm add assessment?');" />
                    <asp:Button ID="btnReset" runat="server" Text="Reset" OnClick="btnReset_Click" />
                </td>
            </tr>
        </table>
    </div>

</asp:Content>

