﻿<%@ Page Language="C#" MasterPageFile="~/assessment.Master" AutoEventWireup="true" CodeBehind="studDoMCQ.aspx.cs" Inherits="OnlineAssessment.studDoMCQ" %>
<%@ Import Namespace="System.Globalization" %>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">

    <div style="width: 70%; margin-left: 15%; margin-top: 3%;">
        <h2 style="margin-bottom: 5px">Answer Multiple Choice Question</h2>
        <div>
            <asp:Label runat="server" ID="questionDetail" Text="">
            </asp:Label>
        </div>
        <div style="text-align: center; margin-top: 20px">
            <asp:Label ID="lblResult" runat="server" Text="" Font-Bold="true"></asp:Label>
            <br />
            <asp:Button ID="btnHome" runat="server" Text="Back to HomePage" OnClick="btnHome_Click" class="btn btn-primary w3-animate-opacity"/>
        </div>
        <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataSource1">
            <ItemTemplate>
                <div style="padding: 15px">
                    Question <%# Container.ItemIndex + 1 %>. <%# Eval("questName") %><br /> 
                    <div>
                        <asp:Image ImageUrl='<%# $"data:image/jpg;base64,{Convert.ToBase64String(Eval("image") is byte[] ? (byte[]) Eval("image") : new Byte[8])}" %>' Visible='<%#Eval("image") is byte[]%>' runat="server" Width="70%" />
                    </div>
                    <div id="div_A" runat="server">
                        <asp:RadioButton GroupName="a" Text='<%# "A. " + Eval("selectA") %>' runat="server" ID="selectA" />
                    </div>
                    <div id="div_B" runat="server">
                        <asp:RadioButton GroupName="a" Text='<%# "B. " + Eval("selectB") %>' runat="server" ID="selectB" />
                    </div>
                    <div id="div_C" runat="server">
                        <asp:RadioButton GroupName="a" Text='<%# "C. " + Eval("selectC") %>' runat="server" ID="selectC" />
                    </div>
                    <div id="div_D" runat="server">
                        <asp:RadioButton GroupName="a" Text='<%# "D. " + Eval("selectD") %>' runat="server" ID="selectD" />
                        <asp:Label ID="questID" runat="server" Visible="false" Text='<%#Eval("questID")%>'></asp:Label>
                    </div>
                </div>
            </ItemTemplate>
        </asp:DataList>
        <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click"
            OnClientClick="return confirm('Confirm to submit');" class="btn btn-primary w3-animate-opacity"/>
        <asp:Button ID="btnReset" runat="server" Text="Reset" OnClick="btnReset_Click" class="btn btn-default w3-animate-opacity"/>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Question] WHERE ([assessID] = @assessID)">
            <SelectParameters>
                <asp:SessionParameter Name="assessID" SessionField="assessID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>

</asp:Content>
