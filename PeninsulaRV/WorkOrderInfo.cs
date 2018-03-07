using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace PeninsulaRV
{
    public class WorkOrderInfo
    {
        private const decimal taxRate = 0.084M;

        private string orderNumber, takenBy, customerName, customerAddress, customerCity, customerState, customerZip, customerPhone, customerAltPhone, vehicleInfo, vehicleType, vehicleVin;
        private DateTime dateOrdered;
        private int mileage, vehicleRef, customerRef;
        private bool exemptLabor, exemptMaterial;
        private decimal jobTotal, materialTotal, miscellaneousTotal, subTotal, salesTax, grandTotal;

        private List<Material> materials = new List<Material>();
        private List<Miscellaneous> miscellaneouss = new List<Miscellaneous>();
        private List<Job> jobs = new List<Job>();

        public List<Material> Materials
        {
            get { return materials; }
            set { materials = value; }
        }

        public List<Miscellaneous> Miscellaneouss
        {
            get { return miscellaneouss; }
            set { miscellaneouss = value; }
        }

        public List<Job> Jobs
        {
            get { return jobs; }
            set { jobs = value; }
        }

        public string OrderNumber
        {
            get { return orderNumber; }
            set { orderNumber = value; }
        }

        public string CustomerName
        {
            get { return customerName; }
            set { customerName = value; }
        }

        public string CustomerAddress
        {
            get { return customerAddress; }
            set { customerAddress = value; }
        }

        public string CustomerCity
        {
            get { return customerCity; }
            set { customerCity = value; }
        }

        public string CustomerState
        {
            get { return customerState; }
            set { customerState = value; }
        }

        public string CustomerZip
        {
            get { return customerZip; }
            set { customerZip = value; }
        }

        public string CustomerPhone
        {
            get { return customerPhone; }
            set { customerPhone = value; }
        }

        public string CustomerAltPhone
        {
            get { return customerAltPhone; }
            set { customerAltPhone = value; }
        }

        public string VehicleInfo
        {
            get { return vehicleInfo; }
            set { vehicleInfo = value; }
        }

        public string VehicleType
        {
            get { return vehicleType; }
            set { vehicleType = value; }
        }

        public string VehicleVin
        {
            get { return vehicleVin; }
            set { vehicleVin = value; }
        }

        public string TakenBy
        {
            get { return takenBy; }
            set { takenBy = value; }
        }

        public DateTime DateOrdered
        {
            get { return dateOrdered; }
            set { dateOrdered = value; }
        }

        public int Mileage
        {
            get { return mileage; }
            set { mileage = value; }
        }

        public int VehicleRef
        {
            get { return vehicleRef; }
            set { vehicleRef = value; }
        }

        public int CustomerRef
        {
            get { return customerRef; }
            set { customerRef = value; }
        }       

        public bool ExemptLabor
        {
            get { return exemptLabor; }
            set { exemptLabor = value; }
        }

        public bool ExemptMaterial
        {
            get { return ExemptLabor; }
            set { exemptMaterial = value; }
        }

        public decimal JobTotal
        {
            get { return jobTotal; }
            set { jobTotal = value; }
        }

        public decimal MaterialTotal
        {
            get { return materialTotal; }
            set { materialTotal = value; }
        }

        public decimal MiscellaneousTotal
        {
            get { return miscellaneousTotal; }
            set { miscellaneousTotal = value; }
        }

        public decimal SubTotal
        {
            get { return jobTotal + materialTotal + miscellaneousTotal; }
        }

        public decimal SalesTax
        {
            get { return salesTax; }
            set { salesTax = value; }
        }

        public decimal GrandTotal
        {
            get { return grandTotal; }
            set { grandTotal = value; }
        }

        public WorkOrderInfo() { }

        public WorkOrderInfo(string orderNumber)
        {
            SqlConnection connection;
            SqlCommand command;
                SqlDataReader reader;
                string query;

                connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

                query = "SELECT * FROM WorkOrderView WHERE OrderNumber = @OrderNumber";

                connection.Open();

                command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@OrderNumber", orderNumber);

                reader = command.ExecuteReader();

                OrderNumber = orderNumber;

                while (reader.Read())
                {
                    CustomerName = reader["Name"].ToString();
                    CustomerAddress = reader["Address"].ToString();
                    CustomerCity = reader["City"].ToString();
                    CustomerState = reader["State"].ToString();
                    CustomerZip = reader["Zip"].ToString();
                    CustomerPhone = reader["PhoneNumber"].ToString();
                    CustomerAltPhone = reader["AltPhoneNumber"].ToString();
                    try
                    {
                        Mileage = Convert.ToInt32(reader["Mileage"]);
                    }
                    catch
                    {
                        Mileage = 0;
                    }

                    VehicleInfo = reader["ModelYear"] + " " + reader["Make"] + " " + reader["Model"];
                    VehicleType = reader["VehicleType"].ToString();
                    VehicleVin = reader["VIN"].ToString();
                    try
                    {
                        Mileage = Convert.ToInt32(reader["Mileage"]);
                    }
                    catch
                    {
                        Mileage = 0;
                    }

                    JobTotal = Convert.ToDecimal(reader["JobTotal"]);
                    MaterialTotal = Convert.ToDecimal(reader["MaterialsTotal"]);
                    MiscellaneousTotal = Convert.ToDecimal(reader["MiscellaneousTotal"]);
                    ExemptLabor = Convert.ToBoolean(reader["ExemptLabor"]);
                    ExemptMaterial = Convert.ToBoolean(reader["ExemptMaterials"]);
                    DateOrdered = Convert.ToDateTime(reader["DateOrdered"]);
                    TakenBy = reader["OrderTakenBy"].ToString();
                    SalesTax = Convert.ToDecimal(reader["SalesTax"]);
                    GrandTotal = Convert.ToDecimal(reader["GrandTotal"]);
                }

                connection.Close();
        }
        
        public string AddWorkOrderToDatabase()
        {
            SqlConnection connection;
            SqlCommand command;
            string query, result;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "INSERT INTO WorkOrder(CustomerRef, VehicleRef, DateOrdered, ExemptLabor, ExemptMaterials, OrderTakenBy, Mileage) Values(@CustomerRef, @VehicleRef, @DateOrdered, @ExemptLabor, @ExemptMaterials, @OrderTakenBy, @Mileage) Select Scope_Identity()";

            connection.Open();
            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@CustomerRef", CustomerRef);
            command.Parameters.AddWithValue("@VehicleRef", VehicleRef);
            command.Parameters.AddWithValue("@DateOrdered", DateOrdered);
            command.Parameters.AddWithValue("@ExemptLabor", ExemptLabor);
            command.Parameters.AddWithValue("@ExemptMaterials", ExemptMaterial);
            command.Parameters.AddWithValue("@OrderTakenBy", TakenBy);
            command.Parameters.AddWithValue("@Mileage", Mileage);            

            result = command.ExecuteScalar().ToString();

            connection.Close();

            return result;
        }

        public void UpdateWOrkOrder()
        {
            SqlConnection connection;
            SqlCommand command;
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "UPDATE WorkOrder SET Mileage = @Mileage, JobTotal = @JobTotal, MaterialsTotal = @MaterialTotal, MiscellaneousTotal = @MiscellaneousTotal, SubTotal = @SubTotal, SalesTax = @SalesTax, GrandTotal = @GrandTotal, ExemptLabor = @ExemptLabor, ExemptMaterials = @ExemptMaterials, DateOrdered = @DateOrdered WHERE OrderNumber = @OrderNumber";

            connection.Open();
            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@Mileage", Mileage);
            command.Parameters.AddWithValue("@JobTotal", JobTotal);
            command.Parameters.AddWithValue("@MaterialTotal", MaterialTotal);
            command.Parameters.AddWithValue("@MiscellaneousTotal", MiscellaneousTotal);
            command.Parameters.AddWithValue("@SubTotal", SubTotal);
            command.Parameters.AddWithValue("@SalesTax", SalesTax);
            command.Parameters.AddWithValue("@GrandTotal", GrandTotal);
            command.Parameters.AddWithValue("@ExemptLabor", ExemptLabor);
            command.Parameters.AddWithValue("@ExemptMaterials", ExemptMaterial);
            command.Parameters.AddWithValue("@DateOrdered", DateOrdered);
            command.Parameters.AddWithValue("@OrderNumber", OrderNumber);

            command.ExecuteScalar();

            connection.Close();
        }

        public void UpdateLaborTaxStatus()
        {
            SqlConnection connection;
            SqlCommand command;
            string query, exempt;

            exempt = "0";

            if (ExemptLabor)
            {
                exempt = "1";
            }

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "UPDATE WorkOrder SET ExemptLabor = @ExemptLabor WHERE OrderNumber = @OrderNumber";

            connection.Open();
            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@ExemptLabor", exempt);
            command.Parameters.AddWithValue("@OrderNumber", OrderNumber);

            command.ExecuteNonQuery();

            connection.Close();
        }

        public void UpdateMaterialsTaxStatus()
        {
            SqlConnection connection;
            SqlCommand command;
            string query, exempt;

            exempt = "0";

            if (ExemptMaterial)
            {
                exempt = "1";
            }

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "UPDATE WorkOrder SET ExemptMaterials = @ExemptMaterials WHERE OrderNumber = @OrderNumber";

            connection.Open();
            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@ExemptMaterials", exempt);
            command.Parameters.AddWithValue("@OrderNumber", OrderNumber);

            command.ExecuteNonQuery();

            connection.Close();
        }

        public DataSet GetMaterialRecords()
        {
            SqlConnection connection;
            SqlDataAdapter adapter;
            DataSet dataset;
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "SELECT * FROM MaterialView WHERE WorkOrderRef = @WorkOrderRef";

            connection.Open();

            adapter = new SqlDataAdapter(query, connection);
            adapter.SelectCommand.Parameters.AddWithValue("@WorkOrderRef", OrderNumber);

            dataset = new DataSet();

            adapter.Fill(dataset);

            connection.Close();

            return dataset;
            
        }

        public DataSet GetJobRecords()
        {
            SqlConnection connection;
            SqlDataAdapter adapter;
            DataSet dataset;
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "SELECT * FROM JobView WHERE WorkOrderRef = @WorkOrderRef";

            connection.Open();

            adapter = new SqlDataAdapter(query, connection);
            adapter.SelectCommand.Parameters.AddWithValue("@WorkOrderRef", OrderNumber);

            dataset = new DataSet();

            adapter.Fill(dataset);
            
            connection.Close();

            return dataset;
        }

        public DataSet GetMiscellaneousRecords()
        {
            SqlConnection connection;
            SqlDataAdapter adapter;
            DataSet dataset;
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "SELECT * FROM Miscellaneous WHERE WorkOrderRef = @WorkOrderRef";

            connection.Open();

            adapter = new SqlDataAdapter(query, connection);
            adapter.SelectCommand.Parameters.AddWithValue("@WorkOrderRef", OrderNumber);

            dataset = new DataSet();

            adapter.Fill(dataset);

            connection.Close();

            return dataset;
        }

        public decimal GetJobTotal()
        {
            SqlConnection connection;
            SqlCommand command;
            string query;
            decimal jobTotal;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "SELECT JobTotal FROM WorkOrder WHERE OrderNumber = @OrderNumber";

            connection.Open();

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@OrderNumber", OrderNumber);

            jobTotal = Convert.ToDecimal(command.ExecuteScalar());

            connection.Close();

            return jobTotal;            
        }

        public decimal GetMaterialsTotal()
        {
            SqlConnection connection;
            SqlCommand command;
            string query;
            decimal materialsTotal;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "SELECT MaterialsTotal FROM WorkOrder WHERE OrderNumber = @OrderNumber";

            connection.Open();

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@OrderNumber", OrderNumber);

            materialsTotal = Convert.ToDecimal(command.ExecuteScalar());

            connection.Close();

            return materialsTotal;
        }

        public decimal GetMiscellaneousTotal()
        {
            SqlConnection connection;
            SqlCommand command;
            string query;
            decimal mischellaneousTotal;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "SELECT MischellaneousTotal FROM WorkOrder WHERE OrderNumber = @OrderNumber";

            connection.Open();

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@OrderNumber", OrderNumber);

            mischellaneousTotal = Convert.ToDecimal(command.ExecuteScalar());

            connection.Close();

            return mischellaneousTotal;
        }

        public void UpdateJobTotal()
        {
            SqlConnection connection;
            SqlCommand command;
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "UPDATE WorkOrder SET JobTotal = @JobTotal WHERE OrderNumber = @OrderNumber";

            connection.Open();

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@OrderNumber", OrderNumber);
            command.Parameters.AddWithValue("@JobTotal", JobTotal);

            command.ExecuteNonQuery();

            connection.Close();
        }

        public void UpdateMaterialsTotal()
        {
            SqlConnection connection;
            SqlCommand command;
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "UPDATE WorkOrder SET MaterialsTotal = @MaterialsTotal WHERE OrderNumber = @OrderNumber";

            connection.Open();

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@OrderNumber", OrderNumber);
            command.Parameters.AddWithValue("@MaterialsTotal", MaterialTotal);

            command.ExecuteNonQuery();

            connection.Close();
        }

        public void UpdateMiscellaneousTotal()
        {
            SqlConnection connection;
            SqlCommand command;
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "UPDATE WorkOrder SET MiscellaneousTotal = @MiscellaneousTotal WHERE OrderNumber = @OrderNumber";

            connection.Open();

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@OrderNumber", OrderNumber);
            command.Parameters.AddWithValue("@MiscellaneousTotal", MiscellaneousTotal);

            command.ExecuteNonQuery();

            connection.Close();
        }

        public WorkOrderInfo GetWorkOrderInfo(string orderNumber)
        {
            WorkOrderInfo workOrderInfo = new WorkOrderInfo();

            SqlConnection connection;
            SqlCommand command;
            SqlDataReader reader;
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "SELECT * FROM WorkOrderView WHERE OrderNumber = @OrderNumber";

            connection.Open();

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@OrderNumber", orderNumber);

            reader = command.ExecuteReader();

            workOrderInfo.OrderNumber = orderNumber;

            while (reader.Read())
            {
                workOrderInfo.CustomerName = reader["Name"].ToString();
                workOrderInfo.CustomerAddress = reader["Address"].ToString();
                workOrderInfo.CustomerCity = reader["City"].ToString();
                workOrderInfo.CustomerState = reader["State"].ToString();
                workOrderInfo.CustomerZip = reader["Zip"].ToString();
                workOrderInfo.CustomerPhone = reader["PhoneNumber"].ToString();
                workOrderInfo.CustomerAltPhone = reader["AltPhoneNumber"].ToString();
                try
                {
                    workOrderInfo.Mileage = Convert.ToInt32(reader["Mileage"]);
                }
                catch
                {
                    workOrderInfo.Mileage = 0;
                }
                
                workOrderInfo.VehicleInfo = reader["ModelYear"] + " " + reader["Make"] + " " + reader["Model"];
                workOrderInfo.VehicleType= reader["VehicleType"].ToString();
                workOrderInfo.VehicleVin = reader["VIN"].ToString();
                try
                {
                    workOrderInfo.Mileage = Convert.ToInt32(reader["Mileage"]);
                }
                catch
                {
                    workOrderInfo.Mileage = 0;
                }
                
                workOrderInfo.JobTotal = Convert.ToDecimal(reader["JobTotal"]);
                workOrderInfo.MaterialTotal = Convert.ToDecimal(reader["MaterialsTotal"]);
                workOrderInfo.MiscellaneousTotal = Convert.ToDecimal(reader["MiscellaneousTotal"]);
                workOrderInfo.ExemptLabor = Convert.ToBoolean(reader["ExemptLabor"]);
                workOrderInfo.ExemptMaterial = Convert.ToBoolean(reader["ExemptMaterials"]);
                workOrderInfo.DateOrdered = Convert.ToDateTime(reader["DateOrdered"]);
                workOrderInfo.TakenBy = reader["OrderTakenBy"].ToString();
                workOrderInfo.SalesTax = Convert.ToDecimal(reader["SalesTax"]);
                workOrderInfo.GrandTotal = Convert.ToDecimal(reader["GrandTotal"]);
            }

            connection.Close();            

            return workOrderInfo;
        }

    }

}