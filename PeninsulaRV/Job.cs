using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace PeninsulaRV
{
    public class Job
    {
        private int workOrderRef;
        private string jobDescription, jobID;
        private decimal jobRate, jobHours;

        public int WorkOrderRef
        {
            get { return workOrderRef; }
            set { workOrderRef = value; }
        }

        public string JobID
        {
            get { return jobID; }
            set { jobID = value;  }
        }

        public string JobDescription
        {
            get { return jobDescription; }
            set { jobDescription = value; }
        }

        public decimal JobRate
        {
            get { return jobRate; }
            set { jobRate = value; }
        }

        public decimal JobHours
        {
            get { return jobHours; }
            set { jobHours = value; }
        }

        public decimal JobAmount
        {
            get { return jobHours * JobRate; }
        }

        public string AddJobToDatabase()
        {
            SqlConnection connection;
            SqlCommand command;
            string query, result;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "INSERT INTO Job(WorkOrderRef, JobDescription, JobRate, JobHours, JobAmount) Values(@WorkOrderRef, @JobDescription, @JobRate, @JobHours, @JobAmount) Select Scope_Identity()";

            connection.Open();
            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@WorkOrderRef", WorkOrderRef);
            command.Parameters.AddWithValue("@JobDescription", JobDescription);
            command.Parameters.AddWithValue("@JobRate", JobRate);
            command.Parameters.AddWithValue("@JobHours", JobHours);
            command.Parameters.AddWithValue("@JobAmount", JobAmount);            

            result = command.ExecuteScalar().ToString();

            connection.Close();

            return result;
        }

        public void UpdateJobDatabase()
        {
            SqlConnection connection;
            SqlCommand command;
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "Update Job SET JobDescription = @JobDescription, JobHours = @JobHours, JobRate = @JobRate WHERE JobID = @JobID";

            connection.Open();
            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@JobDescription", JobDescription);
            command.Parameters.AddWithValue("@JobRate", JobRate);
            command.Parameters.AddWithValue("@JobHours", JobHours);
            command.Parameters.AddWithValue("@JobID", JobID);

            command.ExecuteNonQuery();

            connection.Close();

        }

        public Job GetJobRow(string jobID)
        {
            SqlConnection connection;
            SqlCommand command;
            SqlDataReader reader;
            string query;
            Job job = new Job();        

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "SELECT * FROM Job WHERE JobID = @JobID";

            connection.Open();
            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@JobID", jobID);

            job.jobID = jobID;

            reader = command.ExecuteReader();

            while(reader.Read())
            {
                job.JobRate = Convert.ToDecimal(reader["JobRate"]);
                job.JobHours = Convert.ToDecimal(reader["JobHours"]);
                job.jobDescription = reader["JobDescription"].ToString();
            }

            connection.Close();

            return job;

        }

        public void DeleteJobDatabase()
        {
            SqlConnection connection;
            SqlCommand command;
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "DELETE FROM Job WHERE JobID = @JobID";

            connection.Open();
            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@JobID", JobID);

            command.ExecuteNonQuery();

            connection.Close();

        }

    }
}