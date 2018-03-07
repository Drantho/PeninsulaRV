using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.IO;

namespace PeninsulaRV.secure
{
    public partial class PartView : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string partID = Request.QueryString["PartID"];
                if (string.IsNullOrEmpty(partID))
                {
                    partID = "4";
                }
                Part part = new Part(partID);

                lblCategory.Text = part.Category;
                txtCategory.Text = part.Category;

                lblDescription.Text = part.Description;
                txtDescription.Text = part.Description;

                lblKeywords.Text = part.ListToString(part.KeyWords);
                txtKeywords.Text = part.ListToString(part.KeyWords);

                lblLocation.Text = part.Location;
                txtLocation.Text = part.Location;

                lblName.Text = part.Name;
                txtName.Text = part.Name;

                lblNotes.Text = part.Notes;
                txtNotes.Text = part.Notes;

                lblPrice.Text = part.Price.ToString("C");
                txtPrice.Text = part.Price.ToString();

                lblQuantity.Text = part.Quantity.ToString();
                txtQuantity.Text = part.Quantity.ToString();

                lblStatus.Text = part.Status;
                rblStatus.Items[0].Selected = part.Active;
                rblStatus.Items[1].Selected = !part.Active;

                rptSpecs.DataSource = part.Specs;
                rptSpecs.DataBind();

                int count = 1;
                while (File.Exists(Server.MapPath(@"..\Images\Parts\Part" + Request.QueryString["PartID"] + "-thumb" + count + ".jpg")))
                {
                    System.Web.UI.WebControls.Image image = new System.Web.UI.WebControls.Image();
                    image.ImageUrl = "../Images/Parts/Part" + Request.QueryString["PartID"] + "-thumb" + count + ".jpg";
                    image.CssClass = "img-responsive";
                    plhPhotos.Controls.Add(image);

                    count++;
                }

                Array array = new Array[9];
                rptNewSpecs.DataSource = array;
                rptNewSpecs.DataBind();
            }
            
        }

        protected void UpdatePart(object sender, CommandEventArgs e)
        {
            Part part = new Part(Request.QueryString["PartID"]);

            part.Category = txtCategory.Text;
            part.Description = txtDescription.Text;
            part.KeyWords = part.StringToList(txtKeywords.Text);
            part.Location = txtLocation.Text;
            part.Name = txtName.Text;
            part.Notes = txtNotes.Text;
            part.Price = Convert.ToDecimal(txtPrice.Text);
            part.Quantity = Convert.ToDecimal(txtQuantity.Text);
            part.Active = rblStatus.Items[0].Selected;

            Dictionary<string, string> dictionary = new Dictionary<string, string>();
            foreach(RepeaterItem item in rptSpecs.Items)
            {
                TextBox textBoxKey = item.FindControl("txtKey") as TextBox;
                TextBox textBoxValue = item.FindControl("txtValue") as TextBox;
                
                if (!string.IsNullOrEmpty(textBoxKey.Text))
                {
                    dictionary.Add(textBoxKey.Text, textBoxValue.Text);
                }
                else
                {
                    break;
                }
            }

            foreach(RepeaterItem item in rptNewSpecs.Items)
            {
                TextBox textBoxKey = item.FindControl("txtKey") as TextBox;
                TextBox textBoxValue = item.FindControl("txtValue") as TextBox;
                
                if (!string.IsNullOrEmpty(textBoxKey.Text))
                {
                    dictionary.Add(textBoxKey.Text, textBoxValue.Text);
                }
                else
                {
                    //break;
                }
            }

            part.Specs = dictionary;

            part.UpdatePart();
            Response.Redirect("PartView.aspx?PartID=" + part.PartID);

        }

        protected void UploadImage(object sender, EventArgs e)
        {
            // Check file exist or not  
            if (FileUpload1.PostedFile != null)
            {
                // Check the extension of image  
                string extension = Path.GetExtension(FileUpload1.FileName);
                if (extension.ToLower() == ".png" || extension.ToLower() == ".jpg")
                {
                    Stream strm = FileUpload1.PostedFile.InputStream;
                    using (var image = System.Drawing.Image.FromStream(strm))
                    {
                        int nextPhotoNumber = PhotoCount();
                        var thumbImg1 = ResizedBitmap(strm, 240);
                        // Save the file  
                        string targetPath = Server.MapPath(@"..\Images\Parts\Part" + Request.QueryString["PartID"] + "-thumb" + nextPhotoNumber + ".jpg");
                        thumbImg1.Save(targetPath, image.RawFormat);

                        var thumbImg2 = ResizedBitmap(strm, 600);
                        // Save the file  
                        targetPath = Server.MapPath(@"..\Images\Parts\Part" + Request.QueryString["PartID"] + "-full" + nextPhotoNumber + ".jpg");
                        thumbImg2.Save(targetPath, image.RawFormat);
                        // Print new Size of file (height or Width)  
                        //Show Image  

                        Image1.ImageUrl = @"..\Images\Parts\Part" + Request.QueryString["PartID"] + "-thumb" + nextPhotoNumber + ".jpg";
                        Image2.ImageUrl = @"..\Images\Parts\Part" + Request.QueryString["PartID"] + "-full" + nextPhotoNumber + ".jpg";
                    }
                }
            }
        }

        private int PhotoCount()
        {
            int count = 1;

            while (File.Exists(Server.MapPath(@"..\Images\Parts\Part" + Request.QueryString["PartID"] + "-thumb" + count + ".jpg")))
            {
                count++;
            }
            return count;
        }

        private Bitmap ResizedBitmap(Stream strm, int newHeight)
        {
            using (var image = System.Drawing.Image.FromStream(strm))
            {

                // Print Original Size of file (Height or Width)   
                int newWidth = (image.Width * newHeight) / image.Height; // New Width of Image in Pixel  
                var thumbImg = new Bitmap(newWidth, newHeight);
                var thumbGraph = Graphics.FromImage(thumbImg);
                thumbGraph.CompositingQuality = CompositingQuality.HighQuality;
                thumbGraph.SmoothingMode = SmoothingMode.HighQuality;
                thumbGraph.InterpolationMode = InterpolationMode.HighQualityBicubic;
                var imgRectangle = new Rectangle(0, 0, newWidth, newHeight);
                thumbGraph.DrawImage(image, imgRectangle);
                
                return thumbImg;
            }
        }
    }
}