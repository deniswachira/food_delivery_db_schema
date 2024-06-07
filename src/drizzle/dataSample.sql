-- Insert data into state_table
INSERT INTO state_table (name, code) VALUES
('California', 'CA'),
('Texas', 'TX'),
('New York', 'NY'),
('Florida', 'FL');

-- Insert data into city_table
INSERT INTO city_table (city_name, state_id) VALUES
('Los Angeles', 1),
('San Francisco', 1),
('Houston', 2),
('Miami', 4);

-- Insert data into user_table
INSERT INTO user_table (fullname, email, password) VALUES
('John Doe', 'john@example.com', 'password123'),
('Jane Smith', 'jane@example.com', 'password123'),
('Alice Johnson', 'alice@example.com', 'password123'),
('Bob Brown', 'bob@example.com', 'password123');

-- Insert data into address_table
INSERT INTO address_table (street_address_1, street_address_2, zip_code, delivery_instructions, user_id, city_id) VALUES
('123 Sunset Blvd', 'Apt 101', '90001', 'Leave at the front door', 1, 1),
('456 Market St', 'Suite 200', '94101', 'Ring the bell', 2, 2),
('789 Bay Area', 'Apt 300', '77001', 'Leave at the reception', 3, 3),
('101 Ocean Drive', 'Penthouse', '33101', 'Call upon arrival', 4, 4);

-- Insert data into restaurant_table
INSERT INTO restaurant_table (name, street_address, zip_code, city_id) VALUES
('Good Eats', '123 Main St', '90001', 1),
('Tasty Treats', '456 Oak St', '94101', 2),
('Southern Delights', '789 Pine St', '77001', 3),
('Ocean Bites', '101 Beach St', '33101', 4);

-- Insert data into restaurant_owner_table
INSERT INTO restaurant_owner_table (restaurant_id, owner_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);

-- Insert data into category_table
INSERT INTO category_table (name) VALUES
('Fast Food'),
('Italian'),
('American'),
('Healthy');

-- Insert data into menu_item_table
INSERT INTO menu_item_table (name, price, description, ingredients, restaurant_id, category_id) VALUES
('Burger', 9.99, 'A juicy burger', 'Beef, Lettuce, Tomato, Bun', 1, 1),
('Pizza', 12.99, 'Cheese Pizza', 'Dough, Cheese, Tomato Sauce', 2, 2),
('Pasta', 11.99, 'Pasta with marinara sauce', 'Pasta, Marinara Sauce', 3, 3),
('Salad', 7.99, 'Fresh garden salad', 'Lettuce, Tomato, Cucumber', 4, 4);

-- Insert data into driver_table
INSERT INTO driver_table (car_make, car_model, car_year, user_id, online, delivering) VALUES
('Toyota', 'Camry', 2015, 1, false, false),
('Honda', 'Civic', 2018, 2, true, false),
('Ford', 'Focus', 2016, 3, false, true),
('Chevrolet', 'Malibu', 2017, 4, true, true);

-- Insert data into order_table
INSERT INTO order_table (user_id, driver_id, restaurant_id, delivery_address_id, price, discount, final_price) VALUES
(1, 1, 1, 1, 30.00, 5.00, 25.00),
(2, 2, 2, 2, 40.00, 8.00, 32.00),
(3, 3, 3, 3, 20.00, 2.00, 18.00),
(4, 4, 4, 4, 50.00, 10.00, 40.00);

-- Insert data into comment_table
INSERT INTO comment_table (user_id, order_id, comment_text, is_complaint, is_praise) VALUES
(1, 1, 'Great service!', false, true),
(2, 2, 'Food was cold', true, false),
(3, 3, 'Fast delivery!', false, true),
(4, 4, 'Very satisfied', false, true);

-- Insert data into order_menu_table
INSERT INTO order_menu_table (order_id, menu_item_id, quantity, item_price, price, comment) VALUES
(1, 1, 2, 9.99, 19.98, 'No onions'),
(2, 2, 1, 12.99, 12.99, 'Extra cheese'),
(3, 3, 3, 11.99, 35.97, 'No garlic'),
(4, 4, 4, 7.99, 31.96, 'No dressing');

-- Insert data into order_status_table
INSERT INTO order_status_table (order_id, status_catalog_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);

-- Insert data into status_catalog_table
INSERT INTO status_catalog_table (status) VALUES
('Pending'),
('In Progress'),
('Completed'),
('Cancelled');
