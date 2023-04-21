using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

namespace ShopOnline.Commom
{
    public class UploadImage
    {

		public static string Upload(HttpPostedFileBase file, string path)
		{
			try
			{
				String fileName = GenerateFileName(file.FileName);
				var fullPath = Path.Combine(path, fileName);
				file.SaveAs(fullPath);
				return fileName;
			}
			catch
			{
				return null;
			}
		}

		private static String GenerateFileName(String fileName)
		{
			var uuid = Guid.NewGuid().ToString();
			var index = fileName.LastIndexOf('.');
			var ext = fileName.Substring(index);
			return uuid + ext;
		}

	}
}