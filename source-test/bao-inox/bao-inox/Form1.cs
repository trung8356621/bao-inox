using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace bao_inox
{
    public partial class Form1 : Form
    {
        public static string path;
        private List<int> a_active = new List<int>();
        private string[,] menu = new string[6, 2] { 
            {"cal.png","Lịch làm việc"},//0
            {"user.png","Quản lý nhân viên"},//1
            {"product.png","Quản lý kho"},//2
            {"user.png","Quản lý người dùng"},//3
            {"bill.png","Quản lý đơn hàng"},//4
            {"Pres.png","Thống kê"}//5
        };

        public Form1()
        {
            InitializeComponent();
        }

        void prt_menu()
        {
            int i = 0;
            while (i < this.menu.GetLength(0))
            {
                Panel iterm = this.menu_iterm(i, this.menu[i, 0], this.menu[i, 1]);
                iterm.Location = new Point(i * 130, 0);
                iterm.Size = new System.Drawing.Size(120, 80);

                pmenu.Controls.Add(iterm);
                i++;
            }
            pmenu.Padding = new Padding(10, 0, 10, 0);

        }

        Panel menu_iterm(int num, string icon, string name)
        {
            Panel p = new Panel();
            p.Name = "P_" + num;
            //create picture box
            PictureBox pic = new PictureBox();
            Console.WriteLine(Path.Combine(System.Windows.Forms.Application.StartupPath, @"img/" + icon));
            pic.ImageLocation = Path.Combine(System.Windows.Forms.Application.StartupPath, @"img/" + icon);
            pic.SizeMode = PictureBoxSizeMode.AutoSize;
            pic.Location = new Point(0, 5);
            //create label
            Label lblmenu = new Label();
            lblmenu.Name = "M_" + num;
            lblmenu.Text = name;
            lblmenu.ForeColor = System.Drawing.ColorTranslator.FromHtml("#fff");
            lblmenu.TextAlign = ContentAlignment.MiddleCenter;
            lblmenu.AutoSize = false;
            lblmenu.Font = new System.Drawing.Font("arial", 8, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            lblmenu.Location = new Point(0, 40);
            lblmenu.Size = new System.Drawing.Size(120, 20);
            //create label2
            Label lblborder = new Label();
            lblborder.BackColor = System.Drawing.ColorTranslator.FromHtml("#ab2020");
            lblborder.Location = new Point(0, 70);
            lblborder.Size = new System.Drawing.Size(120, 5);
            lblborder.Visible = false;

            //create panel
            Panel pan2 = new Panel();
            lblmenu.Size = new System.Drawing.Size(120, 80);
            lblmenu.Location = new Point(0, 0);


            //pic.MouseEnter += (e, sender) =>
            //{
            //    this.active(p, lblborder);
            //};
            //p.MouseEnter += (e, sender) =>
            //{
            //    this.active(p, lblborder);
            //};
            //lblmenu.MouseEnter += (e, sender) =>
            //{
            //    this.active(p, lblborder);
            //};

            //pic.MouseLeave += (e, sender) =>
            //{
            //    this.unactive(p, lblborder);
            //};
            //p.MouseLeave += (e, sender) =>
            //{
            //    this.unactive(p, lblborder);
            //};
            //lblmenu.MouseLeave += (e, sender) =>
            //{
            //    this.unactive(p, lblborder);
            //};

            pan2.MouseClick += (e, sender) =>
            {
                this.add_tab(num, name, p, lblborder);
            };

            //p.MouseClick += (e, sender) =>
            //{
            //    this.add_tab(num, name, p, lblborder);
            //};

            //lblmenu.MouseClick += (e, sender) =>
            //{
            //    this.add_tab(num, name, p, lblborder);
            //};

            p.Controls.Add(lblmenu);
            p.Controls.Add(pic);
            p.Controls.Add(lblborder);
            //p.Controls.Add(pan2);
            return p;
        }

        void active(Panel obj, Label lblborder)
        {
            obj.BackColor = System.Drawing.ColorTranslator.FromHtml("#404040");
            lblborder.Visible = true;
        }

        void unactive(Panel obj, Label lblborder)
        {
            obj.BackColor = System.Drawing.ColorTranslator.FromHtml("#363636");
            lblborder.Visible = false;
        }

        void add_tab(int i, string name, Panel obj, Label lblborder)
        {
            if (this.a_active.IndexOf(i) == -1)
            {
                string title = name;
                TabPage myTabPage = new TabPage(title);
                myTabPage.Name = "T_" + i;
                Console.WriteLine("T_" + i);
                Label lbl = new Label();
                lbl.Text = name;
                myTabPage.Controls.Add(lbl);
                tab.TabPages.Add(myTabPage);
                this.active(obj, lblborder);
                this.a_active.Add(i);// dau cho coi
            }
            else
            {
                for (int j = 0; i < tab.TabPages.Count; i++)
                {
                    if (tab.TabPages[j].Name.Equals("T_" + i, StringComparison.OrdinalIgnoreCase))
                    {
                        tab.TabPages.RemoveAt(j);
                        break;
                    }
                }
                this.a_active.Remove(i);
                this.unactive(obj, lblborder);
            }

        }

        private void Form1_Load(object sender, EventArgs e)
        {
            this.a_active.Add(-1);
            WindowState = FormWindowState.Maximized;
            this.Text = "Bảo Inox";
            pmenu.BackColor = System.Drawing.ColorTranslator.FromHtml("#363636");
            this.prt_menu();
        }
    }
}
