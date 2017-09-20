using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace PeninsulaRV
{
    [Serializable]
    public class Vehicle
    {
        private string vehicleID, make, model, vin, description, rvtype, stocknumber;
        private int modelYear, mileage;
        private bool forSale, active, sold, motorized, featured;
        private Customer owner;
        
        public Customer Owner
        {
            get { return owner; }
            set { owner = value; }
        }    

        public string VehicleID
        {
            get { return vehicleID; }
            set { vehicleID = value; }
        }

        public string Make
        {
            get { return make; }
            set { make = value; }
        }

        public string Model
        {
            get { return model; }
            set { model = value; }
        }

        public string VIN
        {
            get { return vin; }
            set { vin = value; }
        }

        public int Mileage
        {
            get { return mileage; }
            set { mileage = value; }
        }

        public string Description
        {
            get { return description; }
            set { description = value; }
        }

        public string RVType
        {
            get { return rvtype; }
            set { rvtype = value; }
        }

        public string Stocknumber
        {
            get { return stocknumber; }
            set { stocknumber = value; }
        }

        public int ModelYear
        {
            get { return modelYear; }
            set { modelYear = value; }
        }

        public bool Motorized
        {
            get { switch (this.RVType)
                {
                    case "Class A Motorhome":
                        motorized = true;
                        break;
                    case "Class B Motorhome":
                        motorized = true;
                        break;
                    case "Class C Motorhome":
                        motorized = true;
                        break;
                    case "Automobile":
                        motorized = true;
                        break;
                    default:
                        motorized = false;
                        break;
                }
                return motorized;
            }
        }

        public bool ForSale
        {
            get { return forSale; }
            set { forSale = value; }
        }

        public bool Featured
        {
            get { return featured; }
            set { featured = value; }
        }

        public bool Active
        {
            get { return active; }
            set { active = value; }
        }

        public bool Sold
        {
            get { return sold; }
            set { sold = value; }
        }

        public string AddVehicleToDatabase()
        {
            SqlConnection connection;
            SqlCommand command;
            string query, vehicleID;

            Customer Owner = new Customer();            

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "INSERT INTO Vehicle(ModelYear, Make, Model, StockNumber, VIN, VehicleType, Mileage, Description, Sale, Sold, Active, CustomerRef) Values(@ModelYear, @Make, @Model, @StockNumber, @VIN, @RVType, @Mileage, @Description, @Sale, @Sold, @Active, @CustomerRef) SELECT Scope_Identity()";
            //query = "INSERT INTO Vehicle(ModelYear, Make, Model, StockNumber, VIN, VehicleType, Mileage, Description, Sale, Sold, Active, CustomerRef) Values(@ModelYear, @Make, @Model, @StockNumber, @VIN, @RVType, @Mileage, @Description, @Sale, @Sold, @Active, @CustomerRef) SELECT Scope_Identity()";
            //query = "INSERT INTO Vehicle(ModelYear, Make, Model, VIN, VehicleType, Mileage, Description, Sale, Sold, Active, CustomerRef) Values(@ModelYear, @Make, @Model, @VIN, @RVType, @RVType, @Description, @Sale, @Sold, @Active, @CustomerRef) SELECT Scope_Identity()";

            connection.Open();

            command = new SqlCommand(query, connection);
            
            command.Parameters.Add(SetDBNullIfEmpty("@ModelYear", ModelYear.ToString()));
            command.Parameters.Add(SetDBNullIfEmpty("@Make", Make));
            command.Parameters.Add(SetDBNullIfEmpty("@Model", Model));
            command.Parameters.Add(SetDBNullIfEmpty("@StockNumber", Stocknumber));
            command.Parameters.Add(SetDBNullIfEmpty("@VIN", VIN));
            command.Parameters.Add(SetDBNullIfEmpty("@RVType", RVType));
            command.Parameters.Add(SetDBNullIfEmpty("@Mileage", Mileage.ToString()));
            command.Parameters.Add(SetDBNullIfEmpty("@Description", Description));
            command.Parameters.AddWithValue("@Sale", ForSale);
            command.Parameters.AddWithValue("@Sold", Sold);
            command.Parameters.AddWithValue("@Active", Active);
            command.Parameters.AddWithValue("@CustomerRef", this.Owner.CustomerID);

            vehicleID = command.ExecuteScalar().ToString();

            connection.Close();

            return vehicleID;
            
        }

        private SqlParameter SetDBNullIfEmpty(string parmName, string parmValueString)
        {
            SqlParameter newSQLParameter = new SqlParameter();
            newSQLParameter.ParameterName = parmName;

            if (string.IsNullOrEmpty(parmValueString))
            {
                newSQLParameter.Value = DBNull.Value;
            }
            else
            {
                newSQLParameter.Value = parmValueString;
            }
            return newSQLParameter;
        }

        public void UpdateVehicle(string field, string value)
        {
            SqlConnection connection;
            SqlCommand command;
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "UPDATE Vehicle SET " + field + " = @" + field + " WHERE VehicleID = @VehicleID";

            connection.Open();

            command = new SqlCommand(query, connection);

            command.Parameters.AddWithValue("@" + field, value);
            command.Parameters.AddWithValue("@VehicleID", VehicleID);
            
            command.ExecuteNonQuery();

            connection.Close();

        }

        public void UpdateAll()
        {

            SqlConnection connection;
            SqlCommand command;
            string query;

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            if(Stocknumber == null)
            {
                query = "UPDATE Vehicle SET ModelYear = @ModelYear, Make = @Make, Model = @Model, VIN = @VIN, VehicleType = @VehicleType, Mileage = @Mileage WHERE VehicleID = @VehicleID";
            }
            else
            {
                query = "UPDATE Vehicle SET StockNumber = @StockNumber, ModelYear = @ModelYear, Make = @Make, Model = @Model, VIN = @VIN, VehicleType = @VehicleType, Mileage = @Mileage, featured = @featured WHERE VehicleID = @VehicleID";
            }
            

            connection.Open();

            command = new SqlCommand(query, connection);

            if (Stocknumber != null)
            {
                command.Parameters.AddWithValue("@StockNumber", Stocknumber);
            }

            command.Parameters.AddWithValue("@ModelYear", ModelYear);
            command.Parameters.AddWithValue("@Make", Make);
            command.Parameters.AddWithValue("@Model", Model);
            command.Parameters.AddWithValue("@VIN", VIN);
            command.Parameters.AddWithValue("@VehicleType", RVType);
            command.Parameters.AddWithValue("@Mileage", Mileage);
            command.Parameters.AddWithValue("@Featured", Featured);
            command.Parameters.AddWithValue("@VehicleID", VehicleID);

            command.ExecuteNonQuery();

            connection.Close();

        }

        public Vehicle GetVehicle(string vehicleID)
        {
            SqlConnection connection;
            SqlCommand command;
            SqlDataReader reader;
            string query;

            Vehicle newVehicle = new Vehicle();

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "SELECT * FROM Vehicle WHERE VehicleID = @VehicleID";

            connection.Open();

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@VehicleID", vehicleID);

            reader = command.ExecuteReader();

            while (reader.Read())
            {
                newVehicle.VehicleID = reader["VehicleID"].ToString();                
                newVehicle.ModelYear = Convert.ToInt32(reader["ModelYear"]);
                newVehicle.Make = reader["Make"].ToString();
                newVehicle.Model = reader["Model"].ToString();
                newVehicle.RVType = reader["VehicleType"].ToString();
                newVehicle.Mileage = Convert.ToInt32(reader["Mileage"]);
                newVehicle.Stocknumber = reader["Stocknumber"].ToString();
                newVehicle.VIN = reader["VIN"].ToString();
                newVehicle.Description = reader["Description"].ToString();                
                try
                {
                    newVehicle.Active = Convert.ToBoolean(reader["Active"]);
                }
                catch
                {
                    newVehicle.Active = true;
                }

                try
                {
                    newVehicle.Featured = Convert.ToBoolean(reader["featured"]);
                }
                catch
                {
                    newVehicle.Active = false;
                }

                try
                {
                    newVehicle.ForSale = Convert.ToBoolean(reader["Sale"]);
                }
                catch
                {
                    newVehicle.ForSale = false;
                }
                try
                {
                    newVehicle.Sold = Convert.ToBoolean(reader["Sold"]);
                }
                catch
                {
                    newVehicle.Sold = false;
                }
                
            }

            return newVehicle;

        }

        public string ReturnVehicleInfo()
        {
            string vehicleInfo;

            vehicleInfo = ModelYear + " " + Make + " " + Model + "<br>" + RVType + "<br>Mileage:" + Mileage;

            return vehicleInfo;
        }

        public string GetNextStocknumber()
        {
            SqlConnection connection;
            SqlCommand command;
            string query;

            Vehicle newVehicle = new Vehicle();

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "SELECT COUNT(VehicleID) + 811 FROM Vehicle WHERE Sale = 1";

            connection.Open();

            command = new SqlCommand(query, connection);

            return command.ExecuteScalar().ToString();
            
        }
        
        public DataSet GetSaleVehicles()
        {
            SqlConnection connection;
            SqlDataAdapter adapter;
            DataSet dataset;
            string query;

            Vehicle newVehicle = new Vehicle();

            connection = new SqlConnection(ConfigurationManager.ConnectionStrings["PeninsulaRV"].ConnectionString);

            query = "SELECT vehicle.vehicleid, vehicle.stocknumber, vehicle.modelyear, vehicle.make, vehicle.model, vehicle.vehicletype, vehicle.vin, vehicle.mileage, sale.askingprice FROM Vehicle inner join sale on sale.vehicleref = vehicle.vehicleid WHERE sale = 1 and sold = 0 and active = 1 ORDER BY VehicleType, ModelYear, Stocknumber";

            connection.Open();

            adapter = new SqlDataAdapter(query, connection);

            dataset = new DataSet();

            adapter.Fill(dataset);

            connection.Close();

            return dataset;
        }
    }
}