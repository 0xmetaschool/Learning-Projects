# Customize the Publish Form on Your Marketplace

Kudos on customizing the dApp so far! In this lesson, we’ll walk through how to update the publish form on your marketplace. Since your marketplace is focused on photos rather than datasets, we’ll modify the text, asset types, and visual elements to create a more relevant experience for your users. Let’s dive in!

## Update Publish Form Text

First, we’ll change the publish form to clarify that it’s meant for publishing and selling photos, not datasets.

1. **Locate the Text Configuration File**
    - Open `content/publish/index.json`.
2. **Edit the Form Text**
    - Find any mentions of “datasets” and change the language to reflect “photos.”
    - Update any descriptive text to explain that this form is specifically for users to upload and sell their photos.
    - We have updated it like this:
        
        ```json
        {
          "title": "Publish",
          "description": "Highlight the important features of your photo to make it more discoverable and catch the interest of the consumers.",
          "warning": "Publishing into a test network first is strongly recommended. Please familiarize yourself with [the market](https://oceanprotocol.com/technology/marketplaces), [the risks](https://blog.oceanprotocol.com/on-staking-on-data-in-ocean-market-3d8e09eb0a13), and the [Terms of Use](/terms).",
          "tooltipAvailableNetworks": "Assets are published to the network your wallet is connected to. These networks are currently supported:"
        }
        ```
        
3. **Save Your Changes**
    - Save the file to apply the new text to your publish form.

## Change Asset Type to “Photo”

To align with your marketplace’s focus on photos, we’ll replace the “dataset” asset type with “photo” in the publish form.

1. **Open the Asset Type File**
    - Go to `src/components/Publish/Metadata/index.tsx`.
2. **Edit the Asset Type Label**
    - On **line 16**, replace “dataset” with “Photo”.
        
        ![oceanc38-ezgif.com-jpg-to-webp-converter.webp](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/refs/heads/main/assests_for_all/Ocean%20C3%20Build%20Decentralized%20Marketplace%20on%20Ocean%20Protocol/Lesson%206%20Customize%20the%20Publish%20Form%20on%20Your%20Market/oceanc38-ezgif.com-jpg-to-webp-converter.webp)
        
    
    Keep your patience, we will soon see the results.
    

## Customize the SVG Waves for Data NFTs

Ocean Market includes an SVG wave generator to create images for Data NFTs. Let’s change these waves to use your brand colors for a cohesive look.

1. **Open the SVG Waves File**
    - Navigate to `src/@utils/SvgWaves.ts`.
2. **Change Wave Colors**
    - Look at **lines 27 to 30** where the wave colors are specified.
        
        ![oceanc39-ezgif.com-jpg-to-webp-converter.webp](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/refs/heads/main/assests_for_all/Ocean%20C3%20Build%20Decentralized%20Marketplace%20on%20Ocean%20Protocol/Lesson%206%20Customize%20the%20Publish%20Form%20on%20Your%20Market/oceanc39-ezgif.com-jpg-to-webp-converter.webp)
        
    - Replace the current pink color with your brand color. For example:
        
        ```tsx
        waveColor: '#YourBrandColor'
        ```
        
3. **Optional: Customize the SVG Design**
    - For more customization, look at **lines 53 to 64**:
        
        ![oceanc310-ezgif.com-jpg-to-webp-converter.webp](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/refs/heads/main/assests_for_all/Ocean%20C3%20Build%20Decentralized%20Marketplace%20on%20Ocean%20Protocol/Lesson%206%20Customize%20the%20Publish%20Form%20on%20Your%20Market/oceanc310-ezgif.com-jpg-to-webp-converter.webp)
        
        - **Change Layer Count**: Adjust the number of layers from 4 to 5, or experiment with different values to see how it affects the visual depth.
        - **Modify Wave Patterns**: Adjust parameters like wave height, amplitude, or frequency to create a unique look.

## Preview Your Customized Publish Form

1. **Save All Changes**
    - Make sure to save all updates to your files.
2. **Restart the Development Server**
    - If your server is running, stop it by pressing **Ctrl + C** (Windows/Linux) or **Cmd + C** (Mac).
    - Restart with `npm start`.
3. **Preview Your Changes**
    - Navigate to **http://localhost:8000/publish** and check that the publish form now invites users to publish photos, offers “Photo” as an asset type, and displays the SVG waves in your brand colors.

![oceanform-ezgif.com-gif-to-webp-converter.webp](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/refs/heads/main/assests_for_all/Ocean%20C3%20Build%20Decentralized%20Marketplace%20on%20Ocean%20Protocol/Lesson%206%20Customize%20the%20Publish%20Form%20on%20Your%20Market/oceanform.webp)

## Wrap Up

Your publish page is now fully customized for your photo marketplace, complete with new text, asset type, and branding colors. This personalization will provide a seamless experience for your users, reinforcing your marketplace's unique identity. Great work!