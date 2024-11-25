# Customize the Styling of Your Marketplace

Welcome back! You were great in the last lesson by updating the name and logo of your marketplace. In this lesson, we’ll go over how to apply your brand’s colors, background, and fonts to make your marketplace truly unique. This includes updating the background, setting your brand colors, and changing the fonts used across the site. Let’s get started!

## Changing the Background

Let’s begin by replacing the default background with your own custom background color or image.

1. **Open the CSS File**
    - Go to the `src/components/App/index.module.css` file in your project.
2. **Set Your Background**
    - On **line 3**, you’ll see the current background setting (e.g., the default wave background).
        
        ![oceanc32-ezgif.com-jpg-to-webp-converter.webp](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/refs/heads/main/assests_for_all/Ocean%20C3%20Build%20Decentralized%20Marketplace%20on%20Ocean%20Protocol/Lesson%205%20Customize%20the%20Styling%20of%20Your%20Marketplace/oceanc32-ezgif.com-jpg-to-webp-converter.webp)
        
    - To apply your own background:
        - **Save your new background image** in the `src/@images/` folder (same folder as your logo).
        - **Update the CSS** by replacing the old background file location with the path to your new background image.
        - We have taken a completely black background and will be using that.
3. **Adjust the Background Position and Repeat**
    - If your background only covers part of the page:
        - Set the background to **start at the top** and **repeat vertically** by updating `background-position` and setting `background-repeat: repeat;`.
        - This will ensure your background image fills the entire page. We will be doing that.
            
            ![oceanc34-ezgif.com-jpg-to-webp-converter.webp](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/refs/heads/main/assests_for_all/Ocean%20C3%20Build%20Decentralized%20Marketplace%20on%20Ocean%20Protocol/Lesson%205%20Customize%20the%20Styling%20of%20Your%20Marketplace/oceanc34-ezgif.com-jpg-to-webp-converter.webp)
            

### Preview

1. **Save All Your Changes**
    - Make sure to save each file after making updates.
2. **Restart Your Development Server**
    - Stop the server if it’s running by pressing **Ctrl + C** (Windows/Linux) or **Cmd + C** (Mac).
    - Restart the server with `npm start`.
3. **Check Your Marketplace**
    - Head to [**http://localhost:8000/**](http://localhost:8000/) and verify that your background, colors, and fonts now match your branding.

    ![oceanc35-ezgif.com-jpg-to-webp-converter.webp](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/refs/heads/main/assests_for_all/Ocean%20C3%20Build%20Decentralized%20Marketplace%20on%20Ocean%20Protocol/Lesson%205%20Customize%20the%20Styling%20of%20Your%20Marketplace/oceanc35-ezgif.com-jpg-to-webp-converter.webp)

## Updating Brand Colors

Now, let’s update the color scheme of your marketplace to align with your brand.

1. **Open the Color Variables File**
    - Go to `src/global/_variables.css`.
    - This file contains global color variables, which define the primary colors used across the site.
2. **Set Your Brand Colors**
    - Review the current color variables, such as `-primary-color` and `-secondary-color`.
    - Replace these values with your brand’s color codes. For example:
        
        ```css
        --primary-color: #YourPrimaryColorCode;
        --secondary-color: #YourSecondaryColorCode;
        ```
        
3. **Experiment with Colors**
    - Feel free to get creative and change as many colors as you need to achieve the look you want.
    - **Save each change** to see how it affects your marketplace in real-time.
    - We haven’t changed this since the purple color matches our theme. But you should go with your own style and show us how it turned out!

## Customizing Fonts

Fonts play an essential role in setting the tone for your brand, so let’s update them to fit your style.

1. **Choose Your Font**
    - If you already have a brand font, you’re ready to go!
    - If not, visit [Google Fonts](https://fonts.google.com/) to explore font options. Google Fonts allows you to preview fonts and provides easy-to-follow instructions for importing them into your project.
2. **Import the Font**
    - If using Google Fonts, copy the provided `@import` code snippet and paste it at the **top of the** `src/stylesGlobal/_variables.css` **file**.
3. **Set the New Font**
    - In the same file (`src/global/_variables.css`), scroll down to **lines 36 to 41** where the font settings are defined.
    - Replace the old font family names with your new font(s). For example:
        
        ```css
        font-family: 'YourFontName', sans-serif;
        ```
        
        I have changed my font, can you see the difference?
        
        ![oceanc36-ezgif.com-jpg-to-webp-converter.webp](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/refs/heads/main/assests_for_all/Ocean%20C3%20Build%20Decentralized%20Marketplace%20on%20Ocean%20Protocol/Lesson%205%20Customize%20the%20Styling%20of%20Your%20Marketplace/oceanc36-ezgif.com-jpg-to-webp-converter.webp)
        
4. **Save and Preview**
    - As with colors, save each change and refresh the page to see how the new font fits with your marketplace.

### Preview

Just iterating the steps for you again:

1. **Save All Your Changes**
    - Make sure to save each file after making updates.
2. **Restart Your Development Server**
    - Stop the server if it’s running by pressing **Ctrl + C** (Windows/Linux) or **Cmd + C** (Mac).
    - Restart the server with `npm start`.
3. **Check Your Marketplace**
    - Head to [**http://localhost:8000/**](http://localhost:8000/) and verify that your background, colors, and fonts now match your branding.

## Wrap up

Congratulations! You’ve successfully customized the styling of your marketplace. Personalizing these design elements is crucial to building a brand identity that stands out. Continue experimenting with these settings until you’re satisfied with the overall look.