# 🥗 Dish — Healthy Eating App

> **TL;DR:**  
> Dish is an iOS app that helps users eat healthier.  
> It recommends recipes based on user preferences using an on-device **Core ML** model.  
> Built with **SwiftUI**, **Core Data**, and **MVVM** architecture.

---

## 🚀 Features

- 📋 **Recipe List** — browse all available dishes with search functionality  
- 🍽️ **Recipe Details** — view ingredients, preparation steps, image, and rate recipes  
- 🛒 **Shopping List** — add ingredients directly from recipes for easy grocery planning  
- ❤️ **Saved Recipes** — save your favorite dishes for quick access  
- 🤖 **Smart Recommendations** — the more you interact, the smarter your recommendations become  

---

## 🧠 Recommendation System

Dish uses **collaborative filtering**, a method that analyzes user preferences and interactions to predict which recipes they might like next.  

- Model trained using **CreateML**  
- Dataset: **Food.com — Recipes and Reviews**  
- Integrated into the app using **CoreML**  
- Works **fully offline** ensuring:
  - ⚡ Fast performance  
  - 🔒 Data privacy  
  - 📱 Autonomous operation  

---

## 🧰 Technologies Used

| Component | Technology |
|------------|-------------|
| UI Framework | **SwiftUI** |
| Data Storage | **Core Data** |
| Machine Learning | **CreateML**, **CoreML** |
| Architecture | **MVVM** |

---

## 📊 Dataset

The app uses the [**Food.com — Recipes and Reviews**](https://www.kaggle.com/datasets/shuyangli94/food-com-recipes-and-user-interactions) dataset,  
which includes thousands of recipes, ingredients, instructions, ratings, and reviews.  

**Data preprocessing included:**
- Cleaning  
- Filtering  
- Normalization  

---

## 🧩 Architecture

Built using the **MVVM (Model–View–ViewModel)** pattern to ensure:
- Clear separation of responsibilities  
- Easy testing and scaling  
- Maintainable code structure  

---

## 📱 App Screens

1. **Recommended Recipes**  
   - Displays all available dishes  
   - Includes search  

2. **Recipe Details**  
   - Shows detailed information including the image, ingredients, and cooking steps  
   - Allows users to rate recipes, save them, and add ingredients to the shopping list

3. **Shopping List**  
   - Displays ingredients to buy  
   - Automatically adds items from recipes  

4. **Saved Recipes**  
   - Lists all favorited dishes  

<p align="center">
  <img src="https://github.com/user-attachments/assets/4568399c-3aaa-44db-b4af-af37cf22c3f6" height=400" />
  <img src="https://github.com/user-attachments/assets/ed28f7ba-34d2-46f2-8e11-56e4417aaaa8" height="400" />
  <img src="https://github.com/user-attachments/assets/6d3c7021-74fa-401c-95e0-cdfbe4900017" height="400" />
  <img src="https://github.com/user-attachments/assets/29273165-51c3-4d14-b853-2a2f6c1a00a4" height="400"/>
</p>

---

## 🌿 Result

Dish is a fully functional iOS app featuring a local **Core ML** recommendation engine.  
It adapts to user interactions, improves over time, and runs completely offline — fast, secure, and private.

---

## 🙌 Author

Developed with ❤️ by **Anastasiia Lysa**  
