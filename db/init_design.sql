-- Create Role table
CREATE TABLE Role (
    id INTEGER PRIMARY KEY,
    name VARCHAR(20) NOT NULL
);

-- Create Version table
CREATE TABLE Version (
    id UUID PRIMARY KEY,
    root_message_id UUID NULL,
    conversation_id UUID NOT NULL,
    parent_version_id UUID NULL,
    FOREIGN KEY (root_message_id) REFERENCES Message(id),
    FOREIGN KEY (conversation_id) REFERENCES Conversation(id),
    FOREIGN KEY (parent_version_id) REFERENCES Version(id)
);

-- Create Conversation table
CREATE TABLE Conversation (
    id UUID PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    created_at DATETIME,
    modified_at DATETIME,
    active_version_id UUID NULL,
    active BOOLEAN DEFAULT false,
    FOREIGN KEY (active_version_id) REFERENCES Version(id)
);

-- Create Message table
CREATE TABLE Message (
    id UUID PRIMARY KEY,
    content TEXT NOT NULL,
    role_id UUID NOT NULL,
    created_at DATETIME,
    version_id UUID NOT NULL,
    FOREIGN KEY (role_id) REFERENCES Role(id),
    FOREIGN KEY (version_id) REFERENCES Version(id)
);




/* 
-- PREVIOUS DATA

Table Role
{
  id integer [primary key]
  name varchar(20) [not null]
}

Table Version
{
  root_message_id UUID [null, ref: > Message.id]
  conversation_id UUID [not null, ref: > Conversation.id]
  parent_version_id UUID [null, ref: > Version.id]
  id UUID [primary key]
}

Table Conversation
{
  id UUID [primary key]
  title varchar(100) [not null]
  created_at datetime
  modified_at datetime
  active_version_id UUID [null, ref: > Version.id]
  active boolean [default: false]
}

Table Message
{
  id UUID [primary key]
  content text [not null]
  role_id UUID [not null, ref: > Role.id]
  created_at datetime
  version_id UUID [not null, ref: > Version.id]
}


*/
