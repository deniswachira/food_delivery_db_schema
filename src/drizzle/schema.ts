import { desc, or, relations } from "drizzle-orm";
import { pgTable, integer, text, boolean, decimal, timestamp, varchar,serial } from "drizzle-orm/pg-core";


// State table 1
export const state_table = pgTable('state_table', {
    state_id: serial('state_id').primaryKey(),
    name: text('name'),
    code: text('code'),
    created_at: timestamp('created_at').defaultNow(),
    updated_at: timestamp('updated_at').defaultNow(),
});

// city table 2
export const city_table = pgTable('city_table', {
    city_id: serial('city_id').primaryKey(),
    city_name: text('city_name'),
    state_id: integer('state_id').notNull().references(()=>state_table.state_id,{onDelete: 'cascade'}),
    created_at: timestamp('created_at').defaultNow(),
    updated_at: timestamp('updated_at').defaultNow(),
});

// address table 3
export const address_table = pgTable('address_table', {
    address_id: serial('address_id').primaryKey(),
    street_address_1: text('street_address_1'),
    street_address_2: text('street_address_2'),
    zip_code: text('zip_code'),
    delivery_instructions: text('delivery_instructions'),
    user_id: integer('user_id').notNull().references(()=>user_table.user_id,{onDelete: 'cascade'}),
    city_id: integer('city_id').notNull().references(()=>city_table.city_id,{onDelete: 'cascade'}),
    created_at: timestamp('created_at').defaultNow(),
    updated_at: timestamp('updated_at').defaultNow(),
});

//user table 4
export const user_table = pgTable( "user_table",{
        user_id: serial("user_id").primaryKey(),
        fullname: varchar("fullname"),
        email: varchar("email").notNull(),
        password: varchar("password").notNull(),
        created_at: timestamp("created_at").defaultNow(),
        updated_at: timestamp("updated_at").defaultNow(),
});
//restaurant table 5
export const restaurant_table = pgTable('restaurant_table', {
    restaurant_id: serial('restaurant_id').primaryKey(),
    name: text('name'),
    street_address: text('street_address'),
    zip_code: text('zip_code'),
    city_id: integer('city_id').notNull().references(()=>city_table.city_id,{onDelete: 'cascade'}),
    created_at: timestamp('created_at').defaultNow(),
    updated_at: timestamp('updated_at').defaultNow(),
});
//restaurant_owner 6
export const restaurant_owner_table = pgTable('restaurant_owner_table', {
    restaurant_owner_id: serial('restaurant_owner_id').primaryKey(),
    restaurant_id: integer("restaurant_id").notNull().references(()=>restaurant_table.restaurant_id,{onDelete:'cascade'}),
    owner_id: integer('owner_id').notNull().references(()=>user_table.user_id,{onDelete:'cascade'}),
});
// new added tables
// menu item table 7
export const menu_item_table = pgTable('menu_item_table', {
    menu_item_id: serial('menu_item_id').primaryKey(),
    name: text('name'),
    price: decimal('price'),
    description: text('description'),
    ingredients: text('ingredients'),
    active: boolean('active').default(true),
    restaurant_id: integer('restaurant_id').notNull().references(()=>restaurant_table.restaurant_id,{onDelete:'cascade'}),
    category_id: integer('category_id').notNull().references(()=>category_table.category_id,{onDelete:'cascade'}),
    created_at: timestamp('created_at').defaultNow(),
    updated_at: timestamp('updated_at').defaultNow(),
});

//category table 8
export const category_table = pgTable('category_table', {
    category_id: serial('category_id').primaryKey(),
    name: text('name'),    
    created_at: timestamp('created_at').defaultNow(),
    updated_at: timestamp('updated_at').defaultNow(),
});

// driver table 9
export const driver_table = pgTable('driver_table', {
    driver_id: serial('driver_id').primaryKey(),
    car_make: text('car_make'),
    car_model: text('car_model'),
    car_year: integer('car_year'),
    user_id: integer('user_id').notNull().references(()=>user_table.user_id,{onDelete:'cascade'}),
    online: boolean('online').default(false),
    delivering: boolean('delivering').default(false),
    created_at: timestamp('created_at').defaultNow(),
    updated_at: timestamp('updated_at').defaultNow(),
});

//order table 10
export const order_table = pgTable('order_table', {
    order_id: serial('order_id').primaryKey(),
    user_id: integer('user_id').notNull().references(()=>user_table.user_id,{onDelete:'cascade'}),
    driver_id: integer('driver_id').references(()=>driver_table.driver_id,{onDelete:'cascade'}),
    restaurant_id: integer('restaurant_id').notNull().references(()=>restaurant_table.restaurant_id,{onDelete:'cascade'}),
    delivery_address_id: integer('delivery_address_id').notNull().references(()=>address_table.address_id,{onDelete:'cascade'}),
    estimated_delivery_time: timestamp('estimated_delivery_time'),
    actual_delivery_time: timestamp('actual_delivery_time'),
    price: decimal('price'),
    discount: decimal('discount'),
    final_price: decimal('final_price'),
    comment: text('comment'),
    created_at: timestamp('created_at').defaultNow(),
    updated_at: timestamp('updated_at').defaultNow(),
});

// comment table 11
export const comment_table = pgTable('comment_table', {
    comment_id: serial('comment_id').primaryKey(),
    user_id: integer('user_id').notNull().references(()=>user_table.user_id,{onDelete:'cascade'}),
    order_id: integer('order_id').notNull().references(()=>order_table.order_id,{onDelete:'cascade'}),
    comment_text: text('comment_text'),
    is_complaint: boolean('is_complaint').default(false),
    is_praise: boolean('is_praise').default(false),
    created_at: timestamp('created_at').defaultNow(),
    updated_at: timestamp('updated_at').defaultNow(),
});

// order_menu table 12
export const order_menu_table = pgTable('order_menu_table', {
    order_menu_id: serial('order_menu_id').primaryKey(),
    order_id: integer('order_id').notNull().references(()=>order_table.order_id,{onDelete:'cascade'}),
    menu_item_id: integer('menu_item_id').notNull().references(()=>menu_item_table.menu_item_id,{onDelete:'cascade'}),
    quantity: integer('quantity'),
    item_price: decimal('item_price'),
    price: decimal('price'),
    comment: text('comment'),
    created_at: timestamp('created_at').defaultNow(),
    updated_at: timestamp('updated_at').defaultNow(),
});


//order_status table 13
export const order_status_table = pgTable('order_status_table', {
    order_status_id: serial('order_status_id').primaryKey(),
    order_id: integer('order_id').notNull().references(()=>order_table.order_id,{onDelete:'cascade'}),
    status_catalog_id: integer('status_catalog_id').notNull().references(()=>status_catalog_table.status_catalog_id,{onDelete:'cascade'}),
    created_at: timestamp('created_at').defaultNow(),
    updated_at: timestamp('updated_at').defaultNow(),
});


//status_catalog table 14
export const status_catalog_table = pgTable('status_catalog_table', {
    status_catalog_id: serial('status_catalog_id').primaryKey(),
    status: text('status'),
    created_at: timestamp('created_at').defaultNow(),
    updated_at: timestamp('updated_at').defaultNow(),
});

//relation between restaurant(1) --> (1)city
export const restaurant_city_relation = relations(restaurant_table, ({ one }) => ({
    city: one(city_table, {
        fields: [restaurant_table.city_id],
        references: [city_table.city_id]
    })
}));
//relation between city(1) --> (n)restaurant
export const city_restaurant_relation = relations(city_table, ({ many }) => ({
    restaurants: many(restaurant_table)
}));

//relation between city(1) --> (1)state
export const city_state_relation = relations(city_table, ({ one }) => ({
    state: one(state_table, {
        fields: [city_table.state_id],
        references: [state_table.state_id]
    })
}));

//relation between state(1) --> (n)cities
export const state_city_relation = relations(state_table, ({ many }) => ({
    cities: many(city_table)
}));

//relation user(1) --> (1) address user(1) --> (1)city user(1) --> (1)state
export const user_address_relation = relations(user_table, ({ one }) => ({
    address: one(address_table,{
        fields: [user_table.user_id],
        references: [address_table.address_id]
    }),
    city: one(city_table,{
        fields: [user_table.user_id],
        references: [city_table.city_id]
    }),
    state: one(state_table,{
        fields: [user_table.user_id],
        references: [state_table.state_id]
    })
}));







//infer types
export type TUser = typeof user_table.$inferInsert;
export type TUserSelect = typeof user_table.$inferSelect;

export type TState = typeof state_table.$inferInsert;
export type TStateSelect = typeof state_table.$inferSelect;

export type TCity = typeof city_table.$inferInsert;
export type TCitySelect = typeof city_table.$inferSelect;

export type TAddress = typeof address_table.$inferInsert;
export type TAddressSelect = typeof address_table.$inferSelect;

export type TRestaurant = typeof restaurant_table.$inferInsert;
export type TRestaurantSelect = typeof restaurant_table.$inferSelect;
