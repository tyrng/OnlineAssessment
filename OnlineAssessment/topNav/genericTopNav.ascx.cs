﻿using System;
using ExceptionManagers;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineAssessment.topNav
{
    public partial class genericTopNav : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void logoText_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/login.aspx");
        }
    }
}