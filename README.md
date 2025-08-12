
# TandemAi – AI-Powered Language Learning App

TandemAi helps you improve your language skills by chatting with an AI partner.  
Choose your **language**, **topic**, and **proficiency level**, and start practicing in a natural, interactive way. The ai chat partner will show mistakes.

---

## Features

- **AI Chat Partner** – Practice real conversations in multiple languages.  
- **Language Selection** – Switch between supported languages.  
- **Custom Topics** – Set the conversation theme.  
- **Language Level** – Adjust difficulty according to your skill level.  
- **API Key Management** – User-provided API key required for AI access.  
- **Multilingual Interface** – Currently available in **English** and **German**.  

---

## Tech Stack

- **Flutter** – Cross-platform UI framework  
- **Flutter Bloc** – State management  
- **GoRouter** – Navigation  
- **Feature-Driven Architecture** – Clean separation of features  
- **L10n** – Built-in localization support  

---

## Project Structure

/features
/chat
chat_settings # Create new chat
ai_chat # chat with ai partner
/profile # Enter Api Key
/about
/l10n # Localizations (German & English)
/routes # App navigation
/shared # Shared widgets & utilities

## Architecture Overview
Feature-Driven Design – Each feature (Chat, Profile, About) is self-contained.

Chat Flow – Starts in chat_settings → launches ai_chat.

Profile – Allows entering & saving API key.

About – Displays legal information.

Shared – Common widgets & utilities.
