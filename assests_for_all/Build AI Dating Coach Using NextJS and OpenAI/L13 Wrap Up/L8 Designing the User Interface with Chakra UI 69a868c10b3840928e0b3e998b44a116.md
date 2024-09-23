# L8: Designing the User Interface with Chakra UI

## **Introduction**

In this lesson, we go through a quick overview of configuring Chakra UI and then creating a clean and modern UI for our homepage and chat interface. We will also make sure that the design is mobile-compatible. So let’s get started! 

## **Setting Up the Project**

We have already done this process but let’s recollect how we installed Chakra UI, Lucide Icons, and other required packages:

```bash
npm install @chakra-ui/react @emotion/react @emotion/styled framer-motion lucide-react
```

## **Configuring the Application**

The `app.js` file sets up the main application layout and theming. It includes:

- **Global Styles**: Custom fonts.
- **Color Mode**: Toggle between light and dark themes.
- **Authentication Handling**: Manage user sessions and display content based on the authentication state.

```jsx
import React from 'react';
import { ChakraProvider, Box, Flex, Heading, Button, useColorMode, Container, useColorModeValue } from '@chakra-ui/react';
import { Sun, Moon, Heart, LogOut } from 'lucide-react';
import { useRouter } from 'next/router';
import theme from '../styles/theme';
import Image from 'next/image';
import { AuthProvider, useAuth } from '../contexts/authContext';
import { Global } from '@emotion/react';

const Fonts = () => (
  <Global
    styles={`@font-face {
      font-family: 'Lobster';
      src: url('/fonts/Lobster.woff2') format('woff2');
      font-weight: normal;
      font-style: normal;
      font-display: swap;
    }`}
  />
);

function AppContent({ Component, pageProps }) {
  const { colorMode, toggleColorMode } = useColorMode();
  const router = useRouter();
  const { user, logout, loading } = useAuth();

  const bgColor = useColorModeValue('gray.50', 'gray.900');
  const textColor = useColorModeValue('gray.800', 'white');
  const headerBgColor = useColorModeValue('white', 'gray.800');
  const headerShadow = useColorModeValue('sm', 'md');

  if (loading) {
    return (
      <Flex height="100vh" alignItems="center" justifyContent="center" bg={bgColor}>
        <Image
          src="/cupidLoading.gif"
          alt="Loading"
          width={300}
          height={300}
        />
      </Flex>
    );
  }

  const isDatingAssistant = router.pathname === '/dating-assistant';

  return (
    <Flex flexDirection="column" minHeight="100vh" bg={bgColor} color={textColor}>
      <Flex
        as="header"
        bg={headerBgColor}
        py={4}
        px={8}
        boxShadow={headerShadow}
        position="sticky"
        top={0}
        zIndex={10}
        alignItems="center"
      >
        <Container maxW="container.xl" display="flex" alignItems="center">
          <Flex alignItems="center" cursor="pointer" onClick={() => router.push('/')} >
            <Heart size={24} color={theme.colors.brand[500]} />
            <Heading
              size="lg"
              color={textColor}
              ml={2}
              fontFamily="Lobster, cursive"
              fontWeight="normal"
              fontSize="4xl"
            >
              Love Guide
            </Heading>
          </Flex>
          <Flex ml="auto" alignItems="center">
            <Button
              onClick={toggleColorMode}
              mr={4}
              variant="ghost"
              size="sm"
              aria-label={colorMode === 'light' ? 'Switch to dark mode' : 'Switch to light mode'}
            >
              {colorMode === 'light' ? <Moon size={18} /> : <Sun size={18} />}
            </Button>
            {user && (
              <Button
                onClick={logout}
                colorScheme="brand"
                size="sm"
                leftIcon={<LogOut size={18} />}
              >
                Logout
              </Button>
            )}
          </Flex>
        </Container>
      </Flex>
      <Flex flexGrow={1} flexDirection="column">
        {isDatingAssistant ? (
          <Component {...pageProps} />
        ) : (
          <Container maxW="container.xl" py={8} flexGrow={1}>
            <Component {...pageProps} />
          </Container>
        )}
      </Flex>
    </Flex>
  );
}

function MyApp({ Component, pageProps }) {
  return (
    <ChakraProvider theme={theme}>
      <Fonts />
      <AuthProvider>
        <AppContent Component={Component} pageProps={pageProps} />
      </AuthProvider>
    </ChakraProvider>
  );
}

export default MyApp;
```

- **Fonts Component**: Injects custom fonts globally.
- **AppContent**: Manages layout and authentication state.
- **MyApp**: Wraps the entire application in `ChakraProvider` and `AuthProvider` for theming and authentication.

## **Designing the Home Page**

The `index.js` file defines the home page. It uses Chakra UI components for layout and styling and incorporates a component for authentication.

```jsx

import { VStack, Text, Box, Fade, useColorModeValue } from '@chakra-ui/react';
import { useAuth } from '../contexts/authContext';

export default function Home() {
  const { AuthComponent } = useAuth();
  const bgColor = useColorModeValue('gray.50', 'gray.900');
  const titleColor = useColorModeValue('brand.600', 'brand.300');
  const subtitleColor = useColorModeValue('gray.600', 'gray.400');

  return (
    <Fade in={true}>
      <VStack spacing={2} minH="80vh" bg={bgColor} justify="center" p={4}>
        <Box textAlign="center">
          <Text fontSize="4xl" fontWeight="bold" color={titleColor} mb={2}>
            Welcome to LoveGuide
          </Text>
          <Text fontSize="xl" color={subtitleColor}>
            Your Personal Dating Coach
          </Text>
          <AuthComponent/>
        </Box>
      </VStack>
    </Fade>
  );
}
```

- **VStack**: Vertically stacks child components with spacing and center alignment.
- **Text**: Displays the main heading and subtitle with dynamic color based on the current color mode.
- **Fade**: Adds a fade-in animation to the content.
- **AuthComponent**: Likely renders sign-up/login forms or related authentication functionality.

### **Implementing Sign-Up/Login Forms**

The `AuthComponent` used in the home page is essential for managing user authentication. Although the exact implementation is abstracted, it typically includes:

- **Sign-Up Form**: Allows new users to create an account.
- **Login Form**: Allows existing users to log in.

**Steps**:

1. **Create `AuthComponent`**: Implement forms for sign-up and login. Use Chakra UI components such as `Input`, `Button`, and `FormControl` to build these forms.
2. **Handle Authentication**: Use context (`AuthProvider` from `authContext`) to manage authentication state and operations.

## **Designing a Chat Interface**

A chat interface is not provided in the code, but here's how you might integrate it into the existing layout:

**Components**:

- **Message Display Area**: Shows chat messages.
- **Input Field**: Allows users to type and send messages.
- **Send Button**: Submits the message.

**Example Layout**:

```jsx

import { VStack, Input, Button, Box, Text, ScrollView } from '@chakra-ui/react';

function ChatInterface() {
  return (
    <VStack spacing={4} align="stretch" p={4} bg="gray.100" height="100%">
      <Box flex="1" overflowY="scroll">
        {/* Messages */}
        <ScrollView>
          <Text>Message 1</Text>
          <Text>Message 2</Text>
        </ScrollView>
      </Box>
      <Box>
        <Input placeholder="Type your message" />
        <Button mt={2} colorScheme="blue">Send</Button>
      </Box>
    </VStack>
  );
}

```

**Explanation**:

- **VStack**: Stacks the chat messages and input field vertically.
- **ScrollView**: Allows scrolling through messages.
- **Input & Button**: Provides a field for typing and sending messages.

## **Applying Responsive Design**

**Objective**: Ensure the application is usable on various devices, especially mobile.

**Techniques**:

- **Fluid Layouts**: Use responsive units like percentages or viewport units instead of fixed sizes.
- **Responsive Props**: Chakra UI’s responsive utility functions (e.g., `p`, `fontSize`) adapt based on screen size.
- **Media Queries**: Utilize Chakra UI’s built-in breakpoints to adjust styles.

**Example**:

- The `VStack` component adapts to different screen sizes using responsive props, ensuring the content is well-aligned on both mobile and desktop.

## Wrap Up

Woohoo!! You have successfully understood key components of your project. Let’s continue this amazing journey ahead and see you in the next lesson!