using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

namespace PeninsulaRV
{
    public class Part
    {
        public string PartID { get; set; }
        public string Name { get; set; }
        public List<string> KeyWords { get; set; }
        public string Description { get; set; }
        public Dictionary<string, string> Specs { get; set; }
        public decimal Price { get; set; }
        public bool Active { get; set; }
        public DateTime ListDate { get; set; }
        public string Location { get; set; }
        public string Notes { get; set; }
        public decimal Quantity { get; set; }
        public string Category { get; set; }
        public string Status
        {
            get
            {
                if (Active)
                {
                    return "Active";
                }
                return "Inactive";
            }
        }

        public Part() { }

        public Part(string partID)
        {
            MyConnection currentConnection = new MyConnection();
            SqlConnection connection = currentConnection.CurrentConnection;
            SqlCommand command;
            SqlDataReader reader;
            string query = "SELECT * FROM Parts WHERE PartID = @PartID";

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@PartID", partID);

            connection.Open();

            reader = command.ExecuteReader();

            while (reader.Read())
            {
                PartID = partID;
                Name = reader["Name"].ToString();
                KeyWords = StringToList(reader["Keywords"].ToString());
                Specs = StringToDict(reader["specs"].ToString());
                Description = reader["Description"].ToString();
                Price = Convert.ToDecimal(reader["Price"]);
                Active = Convert.ToBoolean(reader["Active"]);
                ListDate = Convert.ToDateTime(reader["ListDate"]);
                Location = reader["Location"].ToString();
                Notes = reader["Notes"].ToString();
                Quantity = Convert.ToDecimal(reader["Quantity"]);
                Category = reader["Category"].ToString();
            }
            reader.Close();
            connection.Close();
        }

        public void AddPartToDatabase()
        {
            MyConnection currentConnection = new MyConnection();
            SqlConnection connection = currentConnection.CurrentConnection;
            SqlCommand command;
            string query = "INSERT INTO Parts(Name, Keywords, Description, Specs, Price, Active, ListDate, Location, Notes, Quantity, Category) Values(@Name, @Keywords, @Description, @Specs, @Price, @Active, @ListDate, @Location, @Notes, @Quantity, @Category)";

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@Name", Name);
            command.Parameters.AddWithValue("@KeyWords", ListToString(KeyWords));
            command.Parameters.AddWithValue("@Description", Description);
            command.Parameters.AddWithValue("@Specs", DictToString(Specs));
            command.Parameters.AddWithValue("@Price", Price);
            command.Parameters.AddWithValue("@Active", true);
            command.Parameters.AddWithValue("@ListDate", ListDate);
            command.Parameters.AddWithValue("@Location", Location);
            command.Parameters.AddWithValue("@Notes", Notes);
            command.Parameters.AddWithValue("@Quantity", Quantity);
            command.Parameters.AddWithValue("@Category", Category);

            foreach (SqlParameter parameter in command.Parameters)
            {
                if(parameter.Value == null)
                {
                    parameter.Value = DBNull.Value;
                }
            }

            connection.Open();
            command.ExecuteNonQuery();
            connection.Close();
        }

        public void UpdatePart()
        {
            MyConnection currentConnection = new MyConnection();
            SqlConnection connection = currentConnection.CurrentConnection;
            SqlCommand command;
            string query = "UPDATE Parts Set Name = @Name, Keywords = @Keywords, Description = @Description, Specs = @Specs, Price = @Price, Active = @Active, ListDate = @ListDate, Location = @Location, Notes = @Notes, Quantity = @Quantity, Category = @Category WHERE PartID = @PartID";

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@Name", Name);
            command.Parameters.AddWithValue("@Keywords", ListToString(KeyWords));
            command.Parameters.AddWithValue("@Description", Description);
            command.Parameters.AddWithValue("@Specs", DictToString(Specs));
            command.Parameters.AddWithValue("@Price", Price);
            command.Parameters.AddWithValue("@Active", Active);
            command.Parameters.AddWithValue("@ListDate", ListDate);
            command.Parameters.AddWithValue("@Location", Location);
            command.Parameters.AddWithValue("@Notes", Notes);
            command.Parameters.AddWithValue("@Quantity", Quantity);
            command.Parameters.AddWithValue("@Category", Category);
            command.Parameters.AddWithValue("@PartID", PartID);

            foreach(SqlParameter parameter in command.Parameters)
            {
                if(parameter.Value == null)
                {
                    parameter.Value = DBNull.Value;
                }
            }

            connection.Open();

            command.ExecuteNonQuery();

            connection.Close();


        }

        public List<string> Categories()
        {
            List<string> list = new List<string>();

            MyConnection currentConnection = new MyConnection();
            SqlConnection connection = currentConnection.CurrentConnection;
            SqlCommand command;
            SqlDataReader reader;
            string query = "SELECT DISTINCT Category FROM Parts ORDER BY Category";

            command = new SqlCommand(query, connection);

            connection.Open();

            reader = command.ExecuteReader();
            while (reader.Read())
            {
                list.Add(reader["Category"].ToString());
            }
            reader.Close();
            connection.Close();

            return list;
        }

        public List<Part> AllParts()
        {
            List<Part> list = new List<Part>();

            MyConnection currentConnection = new MyConnection();
            SqlConnection connection = currentConnection.CurrentConnection;
            SqlCommand command;
            SqlDataReader reader;
            string query = "SELECT * FROM Parts ORDER BY Name";

            command = new SqlCommand(query, connection);

            connection.Open();

            reader = command.ExecuteReader();

            while (reader.Read())
            {
                Part part = new Part
                {
                    PartID = reader["PartID"].ToString(),
                    Name = reader["Name"].ToString(),
                    KeyWords = StringToList(reader["Keywords"].ToString()),
                    Specs = StringToDict(reader["specs"].ToString()),
                    Description = reader["Description"].ToString(),
                    Price = Convert.ToDecimal(reader["Price"]),
                    Active = Convert.ToBoolean(reader["Active"]),
                    ListDate = Convert.ToDateTime(reader["ListDate"]),
                    Location = reader["Location"].ToString(),
                    Notes = reader["Notes"].ToString(),
                    Quantity = Convert.ToDecimal(reader["Quantity"]),
                    Category = reader["Category"].ToString()
                };

                list.Add(part);
            }

            connection.Close();

            return list;

        }

        public List<Part> ActiveParts()
        {
            List<Part> list = new List<Part>();

            MyConnection currentConnection = new MyConnection();
            SqlConnection connection = currentConnection.CurrentConnection;
            SqlCommand command;
            SqlDataReader reader;
            string query = "SELECT * FROM Parts WHERE Active = 1 ORDER BY Name";

            command = new SqlCommand(query, connection);

            connection.Open();

            reader = command.ExecuteReader();

            while (reader.Read())
            {
                Part part = new Part
                {
                    PartID = reader["PartID"].ToString(),
                    Name = reader["Name"].ToString(),
                    KeyWords = StringToList(reader["Keywords"].ToString()),
                    Specs = StringToDict(reader["specs"].ToString()),
                    Description = reader["Description"].ToString(),
                    Price = Convert.ToDecimal(reader["Price"]),
                    Active = Convert.ToBoolean(reader["Active"]),
                    ListDate = Convert.ToDateTime(reader["ListDate"]),
                    Location = reader["Location"].ToString(),
                    Notes = reader["Notes"].ToString(),
                    Quantity = Convert.ToDecimal(reader["Quantity"]),
                    Category = reader["Category"].ToString()
                };

                list.Add(part);
            }

            connection.Close();

            return list;

        }

        public List<Part> CategoryParts(string Category)
        {
            List<Part> list = new List<Part>();

            MyConnection currentConnection = new MyConnection();
            SqlConnection connection = currentConnection.CurrentConnection;
            SqlCommand command;
            SqlDataReader reader;
            string query = "SELECT * FROM Parts WHERE Category = @Category ORDER BY Name";

            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@Category", Category);

            connection.Open();

            reader = command.ExecuteReader();

            while (reader.Read())
            {
                Part part = new Part
                {
                    PartID = reader["PartID"].ToString(),
                    Name = reader["Name"].ToString(),
                    KeyWords = StringToList(reader["Keywords"].ToString()),
                    Specs = StringToDict(reader["specs"].ToString()),
                    Description = reader["Description"].ToString(),
                    Price = Convert.ToDecimal(reader["Price"]),
                    Active = Convert.ToBoolean(reader["Active"]),
                    ListDate = Convert.ToDateTime(reader["ListDate"]),
                    Location = reader["Location"].ToString(),
                    Notes = reader["Notes"].ToString(),
                    Quantity = Convert.ToDecimal(reader["Quantity"]),
                    Category = reader["Category"].ToString()
                };

                list.Add(part);
            }

            connection.Close();

            return list;

        }

        public List<Part> SoldParts()
        {
            List<Part> list = new List<Part>();

            MyConnection currentConnection = new MyConnection();
            SqlConnection connection = currentConnection.CurrentConnection;
            SqlCommand command;
            SqlDataReader reader;
            string query = "SELECT * FROM PartSaleView ORDER BY SaleDate, Name";

            command = new SqlCommand(query, connection);

            connection.Open();

            reader = command.ExecuteReader();

            while (reader.Read())
            {
                Part part = new Part
                {
                    PartID = reader["PartID"].ToString(),
                    Name = reader["Name"].ToString(),
                    KeyWords = StringToList(reader["Keywords"].ToString()),
                    Specs = StringToDict(reader["specs"].ToString()),
                    Description = reader["Description"].ToString(),
                    Price = Convert.ToDecimal(reader["Price"]),
                    Active = Convert.ToBoolean(reader["Active"]),
                    ListDate = Convert.ToDateTime(reader["ListDate"]),
                    Location = reader["Location"].ToString(),
                    Notes = reader["Notes"].ToString(),
                    Quantity = Convert.ToDecimal(reader["Quantity"]),
                    Category = reader["Category"].ToString()
                };

                list.Add(part);
            }

            connection.Close();

            return list;
        }

        public List<Part> AvailableParts()
        {
            List<Part> list = new List<Part>();

            MyConnection currentConnection = new MyConnection();
            SqlConnection connection = currentConnection.CurrentConnection;
            SqlCommand command;
            SqlDataReader reader;
            string query = "SELECT * FROM Parts WHERE Quantity > 0 AND Active = 1 ORDER BY Category, Name";

            command = new SqlCommand(query, connection);

            connection.Open();

            reader = command.ExecuteReader();

            while (reader.Read())
            {
                Part part = new Part
                {
                    PartID = reader["PartID"].ToString(),
                    Name = reader["Name"].ToString(),
                    KeyWords = StringToList(reader["Keywords"].ToString()),
                    Specs = StringToDict(reader["specs"].ToString()),
                    Description = reader["Description"].ToString(),
                    Price = Convert.ToDecimal(reader["Price"]),
                    Active = Convert.ToBoolean(reader["Active"]),
                    ListDate = Convert.ToDateTime(reader["ListDate"]),
                    Location = reader["Location"].ToString(),
                    Notes = reader["Notes"].ToString(),
                    Quantity = Convert.ToDecimal(reader["Quantity"]),
                    Category = reader["Category"].ToString()
                };

                list.Add(part);
            }
            reader.Close();

            connection.Close();

            return list;
        }
        
        public string ListToString(List<string> list)
        {
            string result = "";

            foreach(string str in list)
            {
                result += str + ",";
            }

            result = result.Substring(0, result.Length-1);

            return result;
        }

        public string DictToString(Dictionary<string, string> dictionary)
        {
            string result = "";

            foreach(var item in dictionary)
            {
                result += item.Key + ":" + item.Value + ",";
            }

            result = result.Substring(0, result.Length-1);

            return result;
        }

        public List<string> StringToList(string str)
        {
            List<string> list = new List<string>();

            list = str.Split(',').ToList<string>();

            return list;

        }

        public Dictionary<string, string> StringToDict(string str)
        {
            Dictionary<string, string> dictionary = new Dictionary<string, string>();

            List<string> list = StringToList(str);

            foreach(string subString in list)
            {
                var arr = subString.Split(':');
                dictionary.Add(arr[0], arr[1]);
            }

            return dictionary;
        }
    }
}