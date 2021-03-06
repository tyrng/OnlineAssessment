﻿<%@ Page Language="C#" MasterPageFile="~/assessment.Master" AutoEventWireup="true" CodeBehind="enrollLecturers.aspx.cs" Inherits="OnlineAssessment.enrollLecturers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div>
        <h2>Enroll Subject</h2>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT subjectID, (subjectCode + ' ' + subjectName) AS subjectName FROM Subject WHERE subjectID NOT IN 
(SELECT EL.subjectID FROM Subject S, enrollLecturer EL, Lecture L WHERE S.subjectID = EL.subjectID AND L.lecID = EL.lecID AND EL.lecID = @lecID)">
            <SelectParameters>
                <asp:SessionParameter Name="lecID" SessionField="userID" />
            </SelectParameters>
        </asp:SqlDataSource>
        <table class="alt">
            <tr>
                <td>
                    <asp:Label ID="lblSubjectPrompt" runat="server" Text="Please select a subject to enroll :"></asp:Label>
                    <asp:DropDownList ID="ddlSubjectEnroll" runat="server" DataSourceID="SqlDataSource1" DataTextField="subjectName" DataValueField="subjectID">
                    </asp:DropDownList>
                    <br />
                    <br />

                    <span style="float: right">
                        <asp:Button ID="btnEnroll" runat="server" Text="Enroll"
                            OnClientClick="return confirm('Add this subject?');" OnClick="btnEnroll_Click" CssClass="btn btn-primary w3-hover-opacity" />&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:Button ID="btnBackAction" runat="server" Text="Back" OnClick="btnBackAction_Click" CssClass="btn btn-default w3-hover-opacity"  /></span>
                    <br />
                    <p>
                        <asp:Label ID="lblMsg" runat="server" Text="" Style="color: green"></asp:Label>
                    </p>
                </td>
            </tr>
        </table>
    </div>

</asp:Content>
