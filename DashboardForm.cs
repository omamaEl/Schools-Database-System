using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Dashboard
{
    public partial class DashboardForm : Form
    {
        SqlConnection con = new SqlConnection(@"Data Source = OMAMA\SQLEXPRESS ; Initial Catalog = SCHOOL ; Integrated Security=True");

        public DashboardForm()
        {
            InitializeComponent();
        }

        private void panelMain_Paint(object sender, PaintEventArgs e)
        {

        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void btnHome_Click(object sender, EventArgs e)
        {
            // Clear previous content
            panelMain.Controls.Clear();

            //dinamic compountes labels / buttons
            // Create label
            Label S_lbl = new Label();
            S_lbl.Location = new Point(10, 210);
            S_lbl.Font = new Font("Arial", 12, FontStyle.Bold);
            S_lbl.AutoSize = true; 

            // Get student count from database
            SqlCommand S_cmd = new SqlCommand("SELECT COUNT(*) FROM STUDENT", con);
            con.Open();
            int totalStudents = (int)S_cmd.ExecuteScalar(); // returns first column of first row
            con.Close();

            S_lbl.Text = "Total Students: " + totalStudents;

            Label T_lbl = new Label();
            T_lbl.Location = new Point(10,180);
            T_lbl.Font = new Font("Arial", 12, FontStyle.Bold);
            T_lbl.AutoSize = true;

            // Get student/teatcher count from database
            SqlCommand T_cmd = new SqlCommand("SELECT COUNT(*) FROM TEACHER", con);
            con.Open();
            int totalTeachers = (int)T_cmd.ExecuteScalar();
            con.Close();

            T_lbl.Text = "Total Teachers: " + totalTeachers;
           

            Label C_lbl = new Label();
            C_lbl.Location = new Point(10, 240);
            C_lbl.Font = new Font("Arial", 12, FontStyle.Bold);
            C_lbl.AutoSize = true; // important!

            SqlCommand C_cmd = new SqlCommand("SELECT COUNT(*) FROM COURSE", con);
            con.Open();
            int totalCourses = (int)C_cmd.ExecuteScalar();
            con.Close();

            C_lbl.Text = "Total Courses: " + totalCourses;

            //get AVG 
            DataGridView dgv = new DataGridView();
            dgv.Dock = DockStyle.Fill;
            dgv.Location = new Point(10, 150); // X = 10, Y = 150
            dgv.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
            dgv.ReadOnly = true;

            //SQL query
            string AVG = "SELECT S.GRADELEVEL, AVG(E.SCORE) AS AverageGrade " +
                "FROM ENROLLMENT E JOIN STUDENT S " +
                "ON E.STUDENTID = S.STUDENTID " +
                "GROUP BY S.GRADELEVEL " +
                "ORDER BY S.GRADELEVEL;";

            //Execute query and fill DataTable
            SqlDataAdapter da = new SqlDataAdapter(AVG, con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            
            //Bind table to DataGridView
            dgv.DataSource = dt;

            // Add label to content panel
            panelMain.Controls.Add(T_lbl);
            panelMain.Controls.Add(S_lbl);
            panelMain.Controls.Add(C_lbl);
            panelMain.Controls.Add(dgv);

        }

        private void btnStudents_Click(object sender, EventArgs e)
        {
            //clear the panel from past actions
            panelMain.Controls.Clear();

            //dinamic compountes labels / buttons
            //creat the inner buttons
            Button btnAllStudents = new Button();
            btnAllStudents.Text = "Show All Students";
            btnAllStudents.Width = 200;
            btnAllStudents.Height = 40;
            btnAllStudents.Location = new Point(20, 20);
            btnAllStudents.Click += BtnAllStudents_Click;

            Button btnGUARDIAN = new Button();
            btnGUARDIAN.Text = "Student's Guardians";
            btnGUARDIAN.Width = 200;
            btnGUARDIAN.Height = 40;
            btnGUARDIAN.Location = new Point(240, 20);
            btnGUARDIAN.Click += BtnGUARDIAN_Click;

            Button btnStudentCount = new Button();
            btnStudentCount.Text = "Student Count";
            btnStudentCount.Width = 200;
            btnStudentCount.Height = 40;
            btnStudentCount.Location = new Point(20, 80);
            btnStudentCount.Click += BtnStudentCount_Click;

            //add the bottons to the main panel
            panelMain.Controls.Add(btnAllStudents);
            panelMain.Controls.Add(btnGUARDIAN);
            panelMain.Controls.Add(btnStudentCount);


        }

        private void BtnAllStudents_Click(object sender, EventArgs e)
        {
            //clear the panel from past actions
            panelMain.Controls.Clear();

            //creat a header lable 
            Label lbl = new Label();
            lbl.Text = "All Students Information";
            lbl.Font = new Font("Segoe UI", 14, FontStyle.Bold);
            lbl.Location = new Point(20, 10);
            lbl.AutoSize = true;

            //create a new instance of the DataGridView
            // DataGridView is like a table shoes for the user
            DataGridView dgv = new DataGridView();
            dgv.Location = new Point(20, 40);
            dgv.Width = 700;
            dgv.Height = 400;

            //add evry thing to the content panel
            panelMain.Controls.Add(lbl);
            panelMain.Controls.Add(dgv);

            //the SQL query
            string query = @"SELECT 
    S.StudentID, 
    S.FirstName, 
    S.LastName, 
    S.GradeLevel, 
    COUNT(E.OFERINGID) AS NumberOfCourses, 
    S.ContactNumber
FROM STUDENT S
LEFT JOIN ENROLLMENT E
    ON S.StudentID = E.StudentID
GROUP BY 
    S.StudentID, 
    S.FirstName, 
    S.LastName, 
    S.GradeLevel, 
    S.ContactNumber
ORDER BY S.StudentID";

            //SqlDataAdapter is the bridge between your SQL database and a DataTable
            using (SqlDataAdapter da = new SqlDataAdapter(query, con))
            {
                //creat a new empty DataTable and fill it with the data from the query
                DataTable dt = new DataTable();
                da.Fill(dt);
                //the DataGridView Displays all the rows and columns from this table
                dgv.DataSource = dt;
                
            }
        }

        private void BtnGUARDIAN_Click(object sender, EventArgs e)
        {
            panelMain.Controls.Clear();

            Label lbl = new Label();
            lbl.Text = "GURDIANS INFO ";
            lbl.Font = new Font("Segoe UI", 14, FontStyle.Bold);
            lbl.Location = new Point(10, 10);
            lbl.AutoSize = true;

            DataGridView dgv = new DataGridView();
            dgv.Location = new Point(10, 50);
            dgv.Width = panelMain.ClientSize.Width - 20;
            dgv.Height = panelMain.ClientSize.Height - 60;
            dgv.Anchor = AnchorStyles.Top | AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;
            dgv.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
            dgv.ReadOnly = true;

            panelMain.Controls.Add(lbl);
            panelMain.Controls.Add(dgv);

            // Use a verbatim string to keep SQL readable and avoid concatenation issues.
            string query = @"SELECT 
    S.StudentID,
    S.FirstName AS StudentFirstName,
    S.LastName AS StudentLastName,
    G.FirstName AS GuardianFirstName,
    G.LastName AS GuardianLastName,
    G.Relationship,
    G.ContactNumber AS GuardianContact,
    S.Address AS StudentAddress
FROM STUDENT S
LEFT JOIN STUDENT_GUARDIAN SG 
    ON S.StudentID = SG.StudentID
LEFT JOIN GUARDIAN G 
    ON G.GuardianID = SG.GuardianID
ORDER BY S.StudentID";

            try
            {
                using (SqlDataAdapter da = new SqlDataAdapter(query, con))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    dgv.DataSource = dt;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error running query: " + ex.Message);
            }
        }

            private void BtnStudentCount_Click(object sender, EventArgs e)
        {
            panelMain.Controls.Clear();

            Label lbl = new Label();
            lbl.Text = "Number Of Students in Each Level";
            lbl.Font = new Font("Segoe UI", 14, FontStyle.Bold);
            lbl.Location = new Point(10, 10);
            lbl.AutoSize = true;

            DataGridView dgv = new DataGridView();
            dgv.Location = new Point(10, 50);
            dgv.Width = panelMain.ClientSize.Width - 20;
            dgv.Height = panelMain.ClientSize.Height - 60;
            dgv.Anchor = AnchorStyles.Top | AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;
            dgv.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
            dgv.ReadOnly = true;

            panelMain.Controls.Add(lbl);
            panelMain.Controls.Add(dgv);

            // Use a verbatim string to keep SQL readable and avoid concatenation issues.
            string query = @"
            SELECT S.GRADELEVEL , COUNT(S.STUDENTID) AS NUMOFSTUDENT , AVG(SCORE) AS AVGGRADE_SCORE
FROM STUDENT S JOIN ENROLLMENT E 
ON S.STUDENTID = E.STUDENTID
GROUP BY GRADELEVEL";

            try
            {
                using (SqlDataAdapter da = new SqlDataAdapter(query, con))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    dgv.DataSource = dt;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error running query: " + ex.Message);
            }
        }

        private void btnEnroll_Click(object sender, EventArgs e)
        {
            panelMain.Controls.Clear();

            Label lbl = new Label();
            lbl.Text = "Every Course Each Student Is Enrroled in";
            lbl.Font = new Font("Segoe UI", 14, FontStyle.Bold);
            lbl.Location = new Point(20, 20);
            lbl.AutoSize = true;


            DataGridView dgv = new DataGridView();
            dgv.Location = new Point(10, 50);
            dgv.Width = panelMain.ClientSize.Width - 20;
            dgv.Height = panelMain.ClientSize.Height - 60;
            dgv.Anchor = AnchorStyles.Top | AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;
            dgv.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
            dgv.ReadOnly = true;

            panelMain.Controls.Add(lbl);
            panelMain.Controls.Add(dgv);

            string query = @"SELECT S.FIRSTNAME,S.LASTNAME, S.GRADELEVEL, C.COURSENAME ,O.COURSEID
            FROM STUDENT S INNER JOIN ENROLLMENT E 
            ON E.STUDENTID = S.STUDENTID INNER JOIN OFERING O
            ON E.OFERINGID = O.OFERINGID INNER JOIN COURSE C
            ON C.COURSEID = O.COURSEID ";

            using (SqlDataAdapter da = new SqlDataAdapter(query, con))
            {
                DataTable dt = new DataTable();
                da.Fill(dt);
                dgv.DataSource = dt;
            }

        }

        private void btnTeachers_Click(object sender, EventArgs e)
        {
            panelMain.Controls.Clear();

            Button btnTeachersInfo = new Button();
            btnTeachersInfo.Text = "Teachers Info";
            btnTeachersInfo.Width = 200;
            btnTeachersInfo.Height = 40;
            btnTeachersInfo.Location = new Point(20, 20);
            btnTeachersInfo.Click += BtnTeachersInfo_Click;

            Button btnNumOfCourses = new Button();
            btnNumOfCourses.Text = "Num Of Courses";
            btnNumOfCourses.Width = 200;
            btnNumOfCourses.Height = 40;
            btnNumOfCourses.Location = new Point(240, 20);
            btnNumOfCourses.Click += BtnNumOfCourses;

            panelMain.Controls.Add(btnTeachersInfo);
            panelMain.Controls.Add(btnNumOfCourses);

        }


        private void BtnTeachersInfo_Click(object sender, EventArgs e)
        {
            //clear the panel from past actions
            panelMain.Controls.Clear();
            Label lbl = new Label();
            lbl.Text = "All teachers Information";
            lbl.Font = new Font("Segoe UI", 14, FontStyle.Bold);
            lbl.Location = new Point(20, 20);
            lbl.AutoSize = true;


            DataGridView dgv = new DataGridView();
            dgv.Location = new Point(10, 50);
            dgv.Width = panelMain.ClientSize.Width - 20;
            dgv.Height = panelMain.ClientSize.Height - 60;
            dgv.Anchor = AnchorStyles.Top | AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;
            dgv.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
            dgv.ReadOnly = true;

            panelMain.Controls.Add(lbl);
            panelMain.Controls.Add(dgv);

            string query = @"SELECT  
    T.TeacherID,
    T.FirstName,
    T.LastName,
    T.ContactNumber,
    T.Email,
    D.DepartmentName,
    C.CourseName
FROM TEACHER T
JOIN DEPARTMENT D ON T.DepartmentID = D.DepartmentID
LEFT JOIN OFERING O ON T.TeacherID = O.TeacherID
LEFT JOIN COURSE C ON O.CourseID = C.CourseID
ORDER BY T.TeacherID, C.CourseName";

            using (SqlDataAdapter da = new SqlDataAdapter(query, con))
            {
                DataTable dt = new DataTable();
                da.Fill(dt);
                dgv.DataSource = dt;
            }
        }


        private void BtnNumOfCourses(object sender, EventArgs e)
        {
            //clear the panel from past actions
            panelMain.Controls.Clear();
            Label lbl = new Label();
            lbl.Text = "Nmber Of Courses Each Teacher Is teaching";
            lbl.Font = new Font("Segoe UI", 14, FontStyle.Bold);
            lbl.Location = new Point(20, 20);
            lbl.AutoSize = true;


            DataGridView dgv = new DataGridView();
            dgv.Location = new Point(10, 50);
            dgv.Width = panelMain.ClientSize.Width - 20;
            dgv.Height = panelMain.ClientSize.Height - 60;
            dgv.Anchor = AnchorStyles.Top | AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;
            dgv.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
            dgv.ReadOnly = true;

            panelMain.Controls.Add(lbl);
            panelMain.Controls.Add(dgv);

            string query = @"SELECT 
    T.TeacherID,
    T.FirstName,
    T.LastName,
    COUNT(O.CourseID) AS NumCourses
FROM TEACHER T
LEFT JOIN OFERING O ON T.TeacherID = O.TeacherID
GROUP BY T.TeacherID, T.FirstName, T.LastName
ORDER BY NumCourses DESC";

            using (SqlDataAdapter da = new SqlDataAdapter(query, con))
            {
                DataTable dt = new DataTable();
                da.Fill(dt);
                dgv.DataSource = dt;
            }
        }


        private void btnCourses_Click(object sender, EventArgs e)
        {
            panelMain.Controls.Clear();

            Button btnSchedule = new Button();
            btnSchedule.Text = "School Schedules";
            btnSchedule.Width = 200;
            btnSchedule.Height = 40;
            btnSchedule.Location = new Point(20, 20);
            btnSchedule.Click += BtnSchedule_Click;

            Button btnTopStudents = new Button();
            btnTopStudents.Text = "Top student In Each course";
            btnTopStudents.Width = 200;
            btnTopStudents.Height = 40;
            btnTopStudents.Location = new Point(240, 20);
            btnTopStudents.Click += BtnTopStudents_Click;


            //add the bottons to the main panel
            panelMain.Controls.Add(btnSchedule);
            panelMain.Controls.Add(btnTopStudents);


            Label lblSelectCourse = new Label();
            lblSelectCourse.Text = "Select a Course:";
            lblSelectCourse.Font = new Font("Segoe UI", 12, FontStyle.Bold);
            lblSelectCourse.Location = new Point(20, 80);
            lblSelectCourse.AutoSize = true;

            ComboBox cmbCourses = new ComboBox();
            cmbCourses.Location = new Point(20, 110);
            cmbCourses.Width = 300;
            cmbCourses.DropDownStyle = ComboBoxStyle.DropDownList;

            // DataGridView to show schedule
            DataGridView dgvSchedule = new DataGridView();
            dgvSchedule.Location = new Point(20, 160);
            dgvSchedule.Width = panelMain.ClientSize.Width - 40;
            dgvSchedule.Height = panelMain.ClientSize.Height - 180;
            dgvSchedule.Anchor = AnchorStyles.Top | AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;
            dgvSchedule.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
            dgvSchedule.ReadOnly = true;

            panelMain.Controls.Add(lblSelectCourse);
            panelMain.Controls.Add(cmbCourses);
            panelMain.Controls.Add(dgvSchedule);

            LoadCoursesIntoComboBox(cmbCourses);

            // When user selects a course, load its schedule
            cmbCourses.SelectedIndexChanged += (s, ev) =>
            {
                if (cmbCourses.SelectedValue != null)
                {
                    int courseId = (int)cmbCourses.SelectedValue;
                    LoadCourseOffering(courseId, dgvSchedule);
                }
            };

        }

        private void LoadCoursesIntoComboBox(ComboBox cmb)
        {
            string query = "SELECT COURSEID, COURSENAME FROM COURSE";

            using (SqlDataAdapter da = new SqlDataAdapter(query, con))
            {
                DataTable dt = new DataTable();
                da.Fill(dt);

                cmb.DataSource = dt;
                cmb.DisplayMember = "COURSENAME"; // text visible to user
                cmb.ValueMember = "COURSEID";     // actual course ID
            }
        }



        private void LoadCourseOffering(int courseId, DataGridView dgv)
        {
            string query = @"
        SELECT DAYOFWEEK, STARTTIME, ENDTIME, ROOMNUMBER, TEACHERID
        FROM OFERING
        WHERE COURSEID = @CourseID
        ORDER BY
            CASE DAYOFWEEK
                WHEN 'SATURDAY' THEN 1
                WHEN 'SUNDAY' THEN 2
                WHEN 'MONDAY' THEN 3
                WHEN 'TUESDAY' THEN 4
                WHEN 'WEDNESDAY' THEN 5
                WHEN 'THURSDAY' THEN 6
                WHEN 'FRIDAY' THEN 7
            END, STARTTIME";

            using (SqlDataAdapter da = new SqlDataAdapter(query, con))
            {
                da.SelectCommand.Parameters.AddWithValue("@CourseID", courseId);
                DataTable dt = new DataTable();
                da.Fill(dt);
                dgv.DataSource = dt;
            }
        }



        private void BtnSchedule_Click(object sender, EventArgs e)
        {
            //clear the panel from past actions
            panelMain.Controls.Clear();

            //creat a header lable 
            Label lbl = new Label();
            lbl.Text = "School Schedules";
            lbl.Font = new Font("Segoe UI", 14, FontStyle.Bold);
            lbl.Location = new Point(20, 10);
            lbl.AutoSize = true;

            DataGridView dgv = new DataGridView();
            dgv.Location = new Point(10, 50);
            dgv.Width = panelMain.ClientSize.Width - 20;
            dgv.Height = panelMain.ClientSize.Height - 60;
            dgv.Anchor = AnchorStyles.Top | AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;
            dgv.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
            dgv.ReadOnly = true;

            panelMain.Controls.Add(lbl);
            panelMain.Controls.Add(dgv);

            string query = @"SELECT *
FROM OFERING
ORDER BY CASE DAYOFWEEK
    WHEN 'SUNDAY'    THEN 1
    WHEN 'MONDAY'    THEN 2
    WHEN 'TUESDAY'   THEN 3
    WHEN 'WEDNESDAY' THEN 4
    WHEN 'THURSDAY'  THEN 5
    WHEN 'FRIDAY'    THEN 6
    WHEN 'SATURDAY'  THEN 7
END,
STARTTIME";

            using (SqlDataAdapter da = new SqlDataAdapter(query, con))
            {
                DataTable dt = new DataTable();
                da.Fill(dt);
                dgv.DataSource = dt;
            }
        }





        private void BtnTopStudents_Click(object sender, EventArgs e)
        {
            //clear the panel from past actions
            panelMain.Controls.Clear();

            //creat a header lable 
            Label lbl = new Label();
            lbl.Text = "Top students";
            lbl.Font = new Font("Segoe UI", 14, FontStyle.Bold);
            lbl.Location = new Point(20, 10);
            lbl.AutoSize = true;

            DataGridView dgv = new DataGridView();
            dgv.Location = new Point(10, 50);
            dgv.Width = panelMain.ClientSize.Width - 20;
            dgv.Height = panelMain.ClientSize.Height - 60;
            dgv.Anchor = AnchorStyles.Top | AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;
            dgv.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
            dgv.ReadOnly = true;

            panelMain.Controls.Add(lbl);
            panelMain.Controls.Add(dgv);

            string query = @"SELECT 
    S.StudentID,
    S.FirstName,
    S.LastName,
    S.GradeLevel,
    C.CourseName,
    E.Grade,
    E.Score
FROM ENROLLMENT E
JOIN STUDENT S ON S.StudentID = E.StudentID
JOIN OFERING O ON O.OFERINGID = E.OFERINGID
JOIN COURSE C ON C.CourseID = O.CourseID
WHERE E.Score = (
    SELECT MAX(E2.Score)
    FROM ENROLLMENT E2
    JOIN OFERING O2 ON O2.OFERINGID = E2.OFERINGID
    WHERE O2.CourseID = O.CourseID)
ORDER BY C.CourseName, S.StudentID";

            using (SqlDataAdapter da = new SqlDataAdapter(query, con))
            {
                DataTable dt = new DataTable();
                da.Fill(dt);
                dgv.DataSource = dt;
            }
        }






        //Report button
        private void button6_Click(object sender, EventArgs e)
        {
            // Clear previous content
            panelMain.Controls.Clear();

            // Button for failing students
            Button btnFailingStudents = new Button();
            btnFailingStudents.Text = "Failing Students";
            btnFailingStudents.Width = 200;
            btnFailingStudents.Height = 40;
            btnFailingStudents.Location = new Point(20, 20);
            btnFailingStudents.Click += BtnFailingStudents_Click;

            // Button for underperforming teachers
            Button btnLowAvgTeachers = new Button();
            btnLowAvgTeachers.Text = "Teachers Average < 70";
            btnLowAvgTeachers.Width = 200;
            btnLowAvgTeachers.Height = 40;
            btnLowAvgTeachers.Location = new Point(240, 20);
            btnLowAvgTeachers.Click += BtnLowAvgTeachers_Click;

            Button btnGreaterThan95 = new Button();
            btnGreaterThan95.Text = "Atleast One Course > 80";
            btnGreaterThan95.Width = 200;
            btnGreaterThan95.Height = 40;
            btnGreaterThan95.Location = new Point(20, 80);
            btnGreaterThan95.Click += BtnGreaterThan95_Click;

            // Add buttons to panel
            panelMain.Controls.Add(btnFailingStudents);
            panelMain.Controls.Add(btnLowAvgTeachers);
            panelMain.Controls.Add(btnGreaterThan95);
        }

        // Failing Students button click
        private void BtnFailingStudents_Click(object sender, EventArgs e)
        {
            panelMain.Controls.Clear();

            Label lbl = new Label();
            lbl.Text = "Students Who Failed (Grades D and F)";
            lbl.Font = new Font("Segoe UI", 14, FontStyle.Bold);
            lbl.Location = new Point(20, 70);
            lbl.AutoSize = true;

            DataGridView dgv = new DataGridView();
            dgv.Location = new Point(20, 110);
            dgv.Width = 700;
            dgv.Height = 400;

            panelMain.Controls.Add(lbl);
            panelMain.Controls.Add(dgv);

            string query = @"SELECT 
    S.StudentID,
    S.FirstName,
    S.LastName,
    E.Score,
    E.Grade
FROM STUDENT S
JOIN ENROLLMENT E ON S.StudentID = E.StudentID
WHERE E.Grade = 'F'
ORDER BY S.GradeLevel, E.Score DESC";

            using (SqlDataAdapter da = new SqlDataAdapter(query, con))
            {
                DataTable dt = new DataTable();
                da.Fill(dt);
                dgv.DataSource = dt;
            }
        }

        // Low Average Teachers button click
        private void BtnLowAvgTeachers_Click(object sender, EventArgs e)
        {
            panelMain.Controls.Clear();

            Label lbl = new Label();
            lbl.Text = "Teachers with Average Score < 75";
            lbl.Font = new Font("Segoe UI", 14, FontStyle.Bold);
            lbl.Location = new Point(20, 70);
            lbl.AutoSize = true;

            DataGridView dgv = new DataGridView();
            dgv.Location = new Point(20, 110);
            dgv.Width = 700;
            dgv.Height = 400;

            panelMain.Controls.Add(lbl);
            panelMain.Controls.Add(dgv);

            string query = @"SELECT 
    T.TeacherID,
    T.FirstName,
    T.LastName,
    AVG(E.Score) AS AverageScore
FROM TEACHER T
LEFT JOIN OFERING O ON T.TeacherID = O.TeacherID
LEFT JOIN ENROLLMENT E ON O.OFERINGID = E.OFERINGID
GROUP BY T.TeacherID, T.FirstName, T.LastName
HAVING AVG(E.Score) < 75;";

            using (SqlDataAdapter da = new SqlDataAdapter(query, con))
            {
                DataTable dt = new DataTable();
                da.Fill(dt);
                dgv.DataSource = dt;
            }
        }

        private void BtnGreaterThan95_Click(object sender, EventArgs e)
        {
            panelMain.Controls.Clear();

            Label lbl = new Label();
            lbl.Text = "Students Who got 95 Or More in Atleast 1 Course";
            lbl.Font = new Font("Segoe UI", 14, FontStyle.Bold);
            lbl.Location = new Point(20, 70);
            lbl.AutoSize = true;

            DataGridView dgv = new DataGridView();
            dgv.Location = new Point(20, 110);
            dgv.Width = 700;
            dgv.Height = 400;

            panelMain.Controls.Add(lbl);
            panelMain.Controls.Add(dgv);

            string query = @"SELECT DISTINCT
    S.StudentID,
    S.FirstName,
    S.LastName ,
    E.SCORE
FROM STUDENT S
JOIN ENROLLMENT E ON S.StudentID = E.StudentID
WHERE E.Score >= 80
ORDER BY S.StudentID";

            using (SqlDataAdapter da = new SqlDataAdapter(query, con))
            {
                DataTable dt = new DataTable();
                da.Fill(dt);
                dgv.DataSource = dt;
            }
        }


    }
}
