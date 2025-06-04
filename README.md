# 🌍 TripTok

**TripTok** is a travel planning app that allows users to save and organize the places they dream of visiting from all around the world. With smart integrations and a user-friendly interface, TripTok makes trip planning fun and personal!

---

## 🚀 Features

- 🔐 **Authentication (Sign Up / Sign In)**  
  Secure login and registration system using local storage (Hive). The app checks whether a username already exists before allowing sign-up.

- 🗺️ **Add Any Place Worldwide**  
  Users can dynamically search for countries, then view all regions/governorates related to that country.

- 🖼️ **Auto-Fetched Image & Description**  
  Each place includes an automatically loaded image and a brief description, integrated via external APIs.

- 👤 **User Profile**  
  - Displays all the saved places of the user  
  - Allows uploading a personal profile picture

- 🗑️ **Remove Places Anytime**  
  Users have full control to delete any saved location.

- 🎉 **Progress Notification System**  
  A motivational note appears when users successfully add 5 places.

---

## 🧠 Tech Stack

- **Flutter** – For cross-platform UI  
- **Hive** – Used for both local storage and authentication logic  
- **Hive-based Authentication** – We handle sign up and login manually by checking the username in local Hive storage  
- **GeoNames API** – Used to fetch countries and their corresponding regions (governorates)  
- **Unsplash API** – Auto-fetch beautiful images  
- **Wikipedia API** – Auto-fetch place descriptions

---


## 👨‍💻 Team

- Kareem Badr – [GitHub Profile](https://github.com/kareembadr28)
- (Add more team members if needed)

---

## 🛠️ How to Run the Project

```bash
git clone https://github.com/kareembadr28/triptok.git
cd triptok
flutter pub get
flutter run
