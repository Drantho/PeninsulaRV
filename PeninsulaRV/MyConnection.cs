using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;

namespace PeninsulaRV
{
    public class MyConnection
    {
        public SqlConnection CurrentConnection
        {
            get
            {
                SqlConnection connection;
                connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);
                return connection;
            }
        }
    }
}