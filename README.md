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
  - Initially loads 5 articles.  
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
- **Framework:** Flutter  
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
