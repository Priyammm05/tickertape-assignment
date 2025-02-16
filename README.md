# Denik - News App 📱📰  

Denik is a Flutter-based news application that fetches and displays news articles using the NewsAPI. The app provides a seamless user experience with features like offline caching, pagination, and smooth UI transitions.

## Features ✨  

- **Search Functionality** 🔍  
  - Users can search for news on any topic.  
  - The last 5 searched queries are cached and displayed for quick access.  
  - Clicking on a past search query fetches results instantly.  

- **Home Page 🏠**  
  - Fetches the latest news from the API.  
  - The first article is highlighted prominently with an image, title, source, and date.  
  - CachedNetworkImage is used for efficient image loading.  
  - If there's no internet, a default asset image is displayed.  

- **News Detail Page 📜**  
  - Displays complete article details, including image, title, source, date, and description.  
  - Smooth transition animation between home and detail pages.  

- **Pagination & Infinite Scrolling 📄**  
  - Initially loads 5 articles (since most of the time I was getting less then 20 result which was mentioned in the pdf so to make the pagination works more efficiently have made it 5 which can be changed in the constants for any number) 
  - As the user scrolls down, more articles are fetched dynamically.  
  - A shimmer effect is shown during loading.  

- **Offline Support 📡**  
  - Checks for internet connectivity.  
  - If offline, retrieves the last cached news data.  

- **Pull-to-Refresh 🔄**  
  - Users can refresh news articles by pulling down the list.  

- **Error Handling 🚨**  
  - Displays user-friendly error messages for network issues.  
  - Handles API failures and empty search results gracefully.  

## Tech Stack 🛠  
- **Framework:** Flutter (3.19.6 used in the project)
- **State Management:** GetX  
- **Networking:** HTTP package for API calls  
- **Caching:** SharedPreferences
- **UI Enhancements:** CachedNetworkImage, Shimmer Effect


## Flow Diagram

```

         ┌───────────┐
         │   Splash  │
         └────┬──────┘
              │
              ▼
       ┌─────────────┐
       │   Home Page │
       ├─────────────┤
       │  - Fetch News from API |
       │  - Show Cached Data if Offline |
       │  - Highlight First Article |
       │  - Implement Pagination |
       └─────────────┘
              │
              ▼
 ┌──────────────────┐
 │   Search Page    │
 │ - User Enters Query │
 │ - Fetch & Display News  │
 │ - Save Last 5 Queries  │
 └──────────────────┘
              │
              ▼
 ┌──────────────────┐
 │  Detail Page     │
 │ - Show Full News │
 │ - Smooth Animation │
 └──────────────────┘


```

## Video (Drive Link)

```
https://drive.google.com/file/d/1lauINQQGmGSYQdpIesJNrj46jjZ9U0Wo/view?usp=sharing
```

## How to Set Up and Run the Project Locally 🚀  

Follow these steps to set up and run the **Denik** Flutter project on your local machine:  

### Prerequisites ✅  
- Ensure you have **Flutter** installed. You can download it from [Flutter's official site](https://flutter.dev/docs/get-started/install).  
- Install **Dart SDK** (included with Flutter).  
- Set up an emulator or connect a physical device.  
- Get a **NewsAPI key** from [NewsAPI.org](https://newsapi.org/).  

### Steps to Run the Project  

1. **Clone the Repository**  
   ```sh
   git clone https://github.com/Priyammm05/tickertape-assignment
   cd tickertape-assignment

2. **Install Dependencies**  
   ```sh
   flutter pub get

3. **Add API Key**  
   ```sh
   create .env file in assets and add NEWS_API_KEY="YOUR_API_KEY"

4. **Run the App**  
   ```sh
   flutter run

## Areas for Improvement 🚀  

While **Denik** is fully functional, here are some areas where it can be further improved:  

1. **Dark Mode Support 🌙**  
   - Implement a dark theme for better user experience, especially in low-light environments.  

2. **Bookmark Feature 📌**  
   - Allow users to save their favorite articles for later reading.  

3. **Better Error Handling 🚨**  
   - Improve error messages for different failure scenarios like API rate limits, invalid queries, etc.   

4. **User Authentication 🔐**  
   - Implement a simple login/signup system to personalize the news feed based on user preferences.  

These improvements can make **Denik** more powerful and user-friendly! 🚀  

