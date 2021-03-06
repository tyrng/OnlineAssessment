﻿using System;
using ExceptionManagers;
using System.Configuration;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Text;
using System.Web.UI.WebControls;

namespace OnlineAssessment
{
    public partial class lectAssessmentMarks : System.Web.UI.Page
    {
        static int finalmark = 0;
        int TotalMark = 0;
        int stuScore = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["subName"].ToString() != "")
            {
                questionDetail.Text = Session["questType"].ToString() + " - "
                    + Session["assessName"].ToString() + "<br/>Subject : "
                    + Session["subName"].ToString() + "<br/>Assessment Type : "
                    + Session["assessType"].ToString() + "<br>Student ID : "
                    + Session["stuID"].ToString() + "<br>Student Name: "
                    + Session["stuName"].ToString();
            }
            else
            {
                questionDetail.Text = Session["questType"].ToString() + " - "
                    + Session["assessName"].ToString() + "<br/>Assessment Type : "
                    + Session["assessType"].ToString() + "<br>Student ID : "
                    + Session["stuID"].ToString() + "<br>Student Name: "
                    + Session["stuName"].ToString();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string stuAssessID = Session["stuAssessID"].ToString();
                foreach (DataListItem row in DataList1.Items)
                {
                    TextBox lecComment = (TextBox) row.FindControl("lecComment");
                    TextBox score = (TextBox) row.FindControl("stuScore");
                    Label questID = (Label) row.FindControl("questID");
                    Label mark = (Label) row.FindControl("mark");
                    updateStuAns(Convert.ToInt32(stuAssessID), lecComment.Text, Convert.ToInt32(questID.Text),
                        Convert.ToInt32(score.Text));
                    TotalMark += Convert.ToInt32(mark.Text);
                    stuScore += Convert.ToInt32(score.Text);
                    score.ReadOnly = true;
                    lecComment.ReadOnly = true;
                }

                calculateStuScore(TotalMark, stuScore, Convert.ToInt32(stuAssessID));

                lblMsg.Text = "Done marking.. <br/>" +
                              "Student Score: " + finalmark + "%";
                btnSubmit.Visible = false;
                btnReset.Visible = false;
                displayMsg.Visible = true;
                error1.Attributes.Remove("Style");
                error1.Text = "";
                //send email
                string stuEmail = Session["stuEmail"].ToString();
                string stuName = Session["stuName"].ToString();
                string assessName = Session["assessName"].ToString();
                string to = stuEmail;
                string body = "Dear " + stuName + ", your assessment score for " + assessName + " is " + finalmark + "%. ";
                string subject = "Assessment Score for " + assessName;



                Email(to, body, subject, "assessmentpointassignment@gmail.com", "Assessment Point");
            }
            else
            {
                error1.Attributes.Add("Style", "background-color: #ff7d7d;");
                error1.Text = "Cannot submit! Make sure all fields are valid first!";
            }

        }
        protected void btnReset_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/lectAssessmentMarks.aspx", false);
        }
        private void calculateStuScore(int TotalMark, int stuScore, int stuAssID)
        {
            int score = stuScore * 100 / TotalMark;
            finalmark = Convert.ToInt32(score.ToString());
            string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strCon);
            SqlCommand cmd = new SqlCommand("update Student_Assessment set score = '" + finalmark + "', status = 'done' WHERE stuAssessID = " + stuAssID, con);

            try
{
    con.Open();
}
catch (Exception ex)
{
    Response.Redirect(ExceptionManagersHandler.PublishException("MyApplication", ex));
}
            cmd.ExecuteNonQuery();
            con.Close();
        }

        private void updateStuAns(int stuAssessID, String lecComment, int questID, int stuScore)
        {
            string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strCon);
            SqlCommand cmd = new SqlCommand("update StudentAnswer set lecComment = '" + lecComment + "', stuScore= '" + stuScore + "' WHERE stuAssessID = " + stuAssessID + " AND questID = " + questID, con);

            try
{
    con.Open();
}
catch (Exception ex)
{
    Response.Redirect(ExceptionManagersHandler.PublishException("MyApplication", ex));
}
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/lectViewAssessmentList.aspx");
        }

        protected void Email(string to, string body, string subject, string fromAddress, string fromDisplay)
        {
            try
            {
                MailMessage mail = new MailMessage();
                mail.Body = body;
                mail.IsBodyHtml = true;
                mail.To.Add(new MailAddress(to));
                mail.From = new MailAddress(fromAddress, fromDisplay, Encoding.UTF8);
                mail.Subject = subject;
                mail.SubjectEncoding = Encoding.UTF8;
                mail.Priority = MailPriority.Normal;

                SmtpClient smtpClient = new SmtpClient();
                smtpClient.Send(mail);
            }
            catch (Exception)
            {
                Response.Write("Cannot send email! Please check your internet connection!");
            }
        }

    }

}