# Own Your Marketplace

Welcome back! We are excited to have you back! In this lesson, you'll learn how to personalize your marketplace by changing its name and updating the logo. These steps are essential for creating a unique identity for your platform. 

We’ll use our code editor, Visual Studio Code (VS Code), for this process as it offers a straightforward way to search and replace text and organize files.

## Changing Your Marketplace Name

1. **Open Your Code Editor**
    - Start by opening your project in a code editor. In this example, we’ll use VS Code, which has powerful search-and-replace functionality.
2. **Using the Search and Replace Function**
    - In the left-hand panel of VS Code, click on the **magnifying glass icon**. This opens up the search and replace interface.
        
        ![oceanc3-ezgif.com-jpg-to-webp-converter.webp](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/refs/heads/main/assests_for_all/Ocean%20C3%20Build%20Decentralized%20Marketplace%20on%20Ocean%20Protocol/Lesson%204%20Own%20Your%20Marketplace/oceanc3-ezgif.com-jpg-to-webp-converter.webp)
        
    - Here’s how to replace the old name with your custom marketplace name:
        - **Enter “Ocean Marketplace”** in the first textbox (arrow 1 in the example).
        - **Enter your new marketplace name** in the second textbox (arrow 2). We will be naming it Metaschool Marketplace.
        - There’s a button to the right of the second textbox (arrow 3) that will allow you to **replace all instances at once**.
3. **Confirm the Replacements**
    - If you’d like to review each instance before confirming, you can do so. Otherwise, click the replace-all button to make the changes in one go.
        
        ![oceanc31-ezgif.com-jpg-to-webp-converter.webp](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/refs/heads/main/assests_for_all/Ocean%20C3%20Build%20Decentralized%20Marketplace%20on%20Ocean%20Protocol/Lesson%204%20Own%20Your%20Marketplace/oceanc31-ezgif.com-jpg-to-webp-converter.webp)
        
4. **Replacing Other Variants of the Name**
    - Repeat the above steps, this time searching for “Ocean Market” instead of “Ocean Marketplace.”
    - We replaced “Ocean Market” with “Metaschool Market.”

## Updating Your Logo

To make your marketplace visually distinctive, you’ll replace the default logo with your own. We recommend using the SVG format for the best visual quality and scalability.

1. **Locate the Logo File**
    - In your file directory, navigate to `src/@images/logo.svg`.
    - This is where the default logo is stored.
2. **Replace the Logo File**
    - **Delete the existing logo.svg file** in that folder.
    - **Add your logo** by pasting it into the same folder. Ensure it’s in SVG format for compatibility.
3. **Rename Your Logo File**
    - Rename your logo to **`logo.svg`**. This way, the marketplace will automatically pick up your logo without additional changes in the code.

### Step 3: Preview Your Changes

Once you’ve changed the marketplace name and logo, it's time to check how everything looks.

1. **Save All Your Changes**
    - Make sure you save all changes you made in your code editor.
2. **Restart Your Development Server**
    - In your terminal, stop the current build process by pressing **Ctrl + C** (Windows/Linux) or **Cmd + C** (Mac).
    - Start the development server again by running:
        
        ```
        npm start
        ```
        
3. **Preview Your Marketplace**
    - Once the build is complete, navigate to [**http://localhost:8000/**](http://localhost:8000/) to view your updated marketplace.
    - Confirm that your new marketplace name and logo appear correctly.

Here’s what the output looks like for me. Yes, it’s the Metaschool market now!!! What’s yours?

![oceanc33-ezgif.com-jpg-to-webp-converter.webp](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/refs/heads/main/assests_for_all/Ocean%20C3%20Build%20Decentralized%20Marketplace%20on%20Ocean%20Protocol/Lesson%204%20Own%20Your%20Marketplace/oceanc33-ezgif.com-jpg-to-webp-converter.webp)

## Wrap Up

That’s it! You’ve successfully changed the name and logo of your marketplace. Customizing these elements is an essential step toward building a brand identity for your platform. Continue experimenting and personalizing other aspects to make it truly your own.