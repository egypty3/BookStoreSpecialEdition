using BookStore.Models;

namespace BookStore.Data
{
	public static class Phones
	{
		public static List<MobilePhone> GetPhonesList()
		{
			return new List<MobilePhone>
			{
				new MobilePhone {
					Id = 1,
					ManficutureCompany = "Apple",
					PhoneModel = "iPhone 11",
					ReleaseDate = new DateTime(2019, 9, 20),
					FrontCamMegaPixels = 12.0f
				},
				new MobilePhone
				{
					Id = 2,
					ManficutureCompany = "Samsung",
					PhoneModel = "Galaxy S20",
					ReleaseDate = new DateTime(2020, 3, 6),
					FrontCamMegaPixels = 10.0f
				},
				new MobilePhone
				{
					Id = 3,
					ManficutureCompany = "Huawei",
					PhoneModel = "P40 Pro",
					ReleaseDate = new DateTime(2020, 4, 7),
					FrontCamMegaPixels = 32.0f
				},
				new MobilePhone
				{
					Id = 4,
					ManficutureCompany = "Xiaomi",
					PhoneModel = "Mi 10 Pro",
					ReleaseDate = new DateTime(2020, 2, 13),
					FrontCamMegaPixels = 20.0f
				},
				new MobilePhone
				{
					Id = 5,
					ManficutureCompany = "OnePlus",
					PhoneModel = "8 Pro",
					ReleaseDate = new DateTime(2020, 4, 21),
					FrontCamMegaPixels = 16.0f
				},
			};
		}
	}
}
