# Create a unique ID for distinct conversations, where a conversation consists of two users sending each other messages
# Users can send and receive messages; their user id's are unique and fixed, regardless of whether they're sending or receiving a message 
# Each message has a unique id; no two messages have the same id

SELECT * FROM app_messages
LIMIT 4

# OUTPUT
| sender | receiver | message_id | timestamp         |
| 1100   | 1200     | M0021      | 12-01-01 05:03:23 |
| 1200   | 1100     | M0023      | 12-01-01 05:04:56 |
| 1300   | 1200     | M0024      | 12-01-01 05:05:31 |
| 1200   | 1400     | M0025      | 12-01-01 06:45:18 |

# Create Unique identifier for each conversation

SELECT CASE WHEN sender > receiver THEN CONCAT(sender::varchar, receiver::varchar) 
       ELSE CONCAT(receiver::varchar, sender::varchar) END AS convo_id, message_id
FROM app_messages
LIMIT 4

# OUTPUT
| convo_id     | message_id | 
| 12001100     | M0021      | 
| 12001100     | M0023      | 
| 13001200     | M0024      |
| 14001200     | M0025      |


# Count Unique conversations

WITH tb1 AS 

(SELECT CASE WHEN sender > receiver THEN CONCAT(sender::varchar, receiver::varchar) 
       ELSE CONCAT(receiver::varchar, sender::varchar) END AS convo_id, message_id
FROM app_messages
LIMIT 4)

SELECT COUNT(DISTINCT convo_id)
FROM tb1

# OUTPUT
3


