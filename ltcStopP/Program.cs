using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Xsl;   // Xslt types
using System.IO;        // Directory class

namespace ltcStopP
{
    class Program
    {
        private const string XML_FILE = @"..\..\..\ltcstops.xml";
        private const string HTML_FILE = @"..\..\..\ltcstop.html";
        private const string XSLT_FILE = @"..\..\..\ltcstop.xslt";
        static void Main(string[] args)
        {
            // Display a title
            Console.WriteLine("London Transit Commission Bus Stop Report");
            Console.WriteLine("------------------------------------------");
            Console.WriteLine("Provide a street name or partial street name exactly as it appears in the xml file");
         
            // Enter the information
            Console.Write("\nEnter a street name: ");
            string streetName = Console.ReadLine().ToUpper().Trim(); 

           
            try
            {
                // Create a new XslTransform object and load the style sheet
                XslCompiledTransform xslt = new XslCompiledTransform();
                xslt.Load(XSLT_FILE);

                // Set-up an XsltArgumentList object to pass to the 
                // XSLT file's 'character' parameter
                XsltArgumentList xsltArgList = new XsltArgumentList();
                xsltArgList.AddParam("street", "", streetName);

                // Execute the transformation 
                FileStream outFile = File.Create(HTML_FILE);
                xslt.Transform(XML_FILE, xsltArgList, outFile);
                outFile.Close();
                // Display the transformed XML file in Internet Explorer

                // The rutime folder used by the Internet Explorer (IE) program is 
                // different from the one used by our C# program. So we're going to give
                // IE the absolute path to the XML file by using the GetCurrentDirectory() method.
                System.Diagnostics.Process proc = new System.Diagnostics.Process();
                proc.StartInfo.FileName = "iexplore";
                proc.StartInfo.Arguments = Directory.GetCurrentDirectory().ToString() + "\\" + HTML_FILE;
                proc.Start();
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: {0}", ex.Message);
            }

        }//end main
    }//end class
}//end namespace
