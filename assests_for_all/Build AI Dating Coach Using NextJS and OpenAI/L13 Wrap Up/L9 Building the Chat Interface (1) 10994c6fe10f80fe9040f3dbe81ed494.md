# L9: Building the Chat Interface (1)

In this lesson, we’ll walk through the process of creating a functional chat interface where users can interact by asking questions. We’ll cover both the frontend components responsible for user interaction and the logic needed to handle the chat messages between the user and an assistant. 

## Designing the Chat Interface

The chat interface consists of three primary parts:

1. **Chat Log**: Displays messages from the user and assistant.
2. **Input Form**: Allows users to type their questions and send them.
3. **Message Handling**: Processes user input and displays the responses.

## Creating the Chat Message Component

The `ChatMessage` component is responsible for rendering individual messages in the chat log. It needs to handle two types of messages:

- Messages from the **user**, which are aligned to the right.
- Messages from the **assistant**, which are aligned to the left and include an avatar for easy identification.

```jsx

const ChatMessage = ({ message }) => {
  const isAssistant = message.role === 'assistant'; // Check if the message is from the assistant

  return (
    <Flex
      w="full"
      py={3}
      justify={isAssistant ? "flex-start" : "flex-end"} // Align messages based on sender
    >
      <Flex
        maxW="70%" // Message bubble width
        align="start"
        bg={isAssistant ? undefined : 'brand.500'} // Different background for user messages
        color={isAssistant ? 'inherit' : 'white'}
        px={4}
        py={3}
        borderRadius="lg"
      >
        {isAssistant && (
          <Avatar
            icon={<Icon as={MessageSquare} />} // Display an avatar for assistant messages
            bg="brand.500"
            color="white"
            mr={3}
            size="sm"
          />
        )}
        <Text>{message.content}</Text>
      </Flex>
    </Flex>
  );
};

```

- The `message.role` determines whether the message is from the user or the assistant. Based on this, the layout is adjusted (left or right alignment).
- If the message is from the assistant, an avatar is shown to differentiate it visually.
- User messages have a custom background color to further highlight the difference between user and assistant interactions.

## Setting Up the Input Form

The input form allows users to type their questions and submit them. This component needs to collect the input, clear the input field after submission, and trigger the chat response logic.

```jsx

const handleSubmit = async (e) => {
  e.preventDefault();
  if (!input.trim()) return; // Avoid sending empty messages

  setConversation(prev => [...prev, { role: 'user', content: input }]); // Update conversation log with user input
  setInput(''); // Clear input field

  setIsLoading(true); // Show loading indicator while the assistant is responding

  // Simulate API call to get assistant's response
  const response = await fetch('/api/chat', {
    method: 'POST',
    body: JSON.stringify({ input }),
  });

  const data = await response.json(); // Assuming the API returns the assistant's message

  setConversation(prev => [...prev, { role: 'assistant', content: data.reply }]); // Update conversation log with assistant response
  setIsLoading(false); // Hide loading indicator
};

```

- When the form is submitted, it triggers the `handleSubmit` function, which first checks if the input field is empty. If it isn’t, the user’s message is added to the `conversation` array (which keeps track of the chat log).
- After the user’s message is submitted, an API call is made to fetch the assistant’s response. Once received, the assistant’s message is also added to the conversation log.
- The input field is cleared after submission, and a loading indicator is displayed while waiting for the assistant’s response.

## Displaying the Conversation

The conversation log is a list of messages displayed in order. Each message is either from the user or the assistant, and we use the `ChatMessage` component to render them.

```jsx

export default function DatingAssistantPage() {
  const [input, setInput] = useState(''); // Stores the user's current input
  const [conversation, setConversation] = useState([]); // Stores the chat log
  const [isLoading, setIsLoading] = useState(false); // Loading state for assistant response

  const messagesEndRef = useRef(null); // Reference to the end of the chat log

  useEffect(() => {
    // Scroll to the bottom of the chat log whenever a new message is added
    messagesEndRef.current?.scrollIntoView({ behavior: "smooth" });
  }, [conversation]);

  return (
    <Flex direction="column" h="100vh">
      {/* Chat log */}
      <Box flex={1} overflowY="auto" px={4} py={6}>
        <VStack spacing={4} align="stretch" maxW="3xl" mx="auto">
          {conversation.map((message, index) => (
            <ChatMessage key={index} message={message} />
          ))}
          {isLoading && <TypingIndicator />}
          <div ref={messagesEndRef} /> {/* Keeps track of the bottom of the chat */}
        </VStack>
      </Box>

      {/* Input form */}
      <Box borderTop="1px" p={4}>
        <Flex as="form" onSubmit={handleSubmit}>
          <Input
            value={input}
            onChange={(e) => setInput(e.target.value)} // Update input state
            placeholder="Ask a question..."
            mr={2}
          />
          <Button type="submit" isLoading={isLoading}>Send</Button>
        </Flex>
      </Box>
    </Flex>
  );
}

```

- The `conversation` state keeps track of all messages exchanged between the user and assistant.
- Each message is passed to the `ChatMessage` component for rendering.
- We use a `useRef` hook to keep track of the bottom of the chat log and automatically scroll to the latest message whenever a new message is added to the conversation.
- The form at the bottom allows the user to type and submit their input. The input field is cleared and ready for new input after each submission.

## Adding a Typing Indicator

To make the chat feel more interactive, we can add a typing indicator that shows when the assistant is "thinking" or responding to the user.

```jsx

const TypingIndicator = () => (
  <Flex align="center" mt={2}>
    <Text fontSize="xl" color="gray.500">•</Text>
    {[0, 1].map((index) => (
      <Text
        key={index}
        fontSize="xl"
        color="gray.500"
        animation={`typing-indicator 1.4s infinite ease-in-out ${index * 0.2}s`}
        ml={1}
      >
        •
      </Text>
    ))}
  </Flex>
);

```

- The typing indicator uses simple dots to simulate typing. The dots are animated to appear one after the other, creating the illusion of typing activity. The indicator is displayed when the assistant is formulating a response.

## Wrap Up

By following this structure, we’ve built a simple chat interface that allows users to interact with an assistant. It was super interesting, isn’t it? See you in the next lesson!