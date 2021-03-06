<%@ Page Language="C#" MasterPageFile="~/assessment.Master" AutoEventWireup="true" CodeBehind="EnrollStudents.aspx.cs" Inherits="OnlineAssessment.EnrollStudents" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <h2>Enroll Student</h2>

        <table class="alt">
            <tr>
                <td>
                    <asp:Label ID="lblSubjectPrompt" runat="server" Text="Please select a student to enroll :"></asp:Label>
                    <asp:DropDownList ID="ddlStudentEnroll" runat="server" DataSourceID="SqlDataSource1" DataTextField="studName" DataValueField="stuID">
                    </asp:DropDownList>
                    <br />
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT stuID, (CAST(stuID AS NVARCHAR(10)) + ' ' + stuName) AS studName FROM student WHERE stuID NOT IN 
(SELECT ES.stuID FROM EnrollStudent ES, student S WHERE S.stuID = ES.stuID AND ES.subjectID = @subjectID)">
                        <SelectParameters>
                            <asp:SessionParameter Name="subjectID" SessionField="subjectID" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <br />

                    <span style="float: right">
                        <asp:Button ID="btnEnroll" runat="server" Text="Enroll"
                            OnClientClick="return confirm('Add this student?');" OnClick="btnEnroll_Click" class="btn btn-primary w3-animate-opacity"/>&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:Button ID="btnBackAction" runat="server" Text="Back" OnClick="btnBackAction_Click" class="btn btn-default w3-animate-opacity"/></span>
                    <br />
                    <p>
                        <asp:Label ID="lblMsg" runat="server" Text="" Style="color: green"></asp:Label>
                    </p>
                </td>
            </tr>

        </table>
    </div>


</asp:Content>
