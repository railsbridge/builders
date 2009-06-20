# TrixyScopes

Collection of useful named scopes for rails apps.
Additional methods are based on column name and type
ie: Product.name_is("ipod"), Product.price_greater_than(100)

Datetime columns ending with **_at** get also functional aliases:

Product.updated_at_before('2008-01-01') becomes:
Product.updated_before('2008-01-01')

## Installation


script/plugin install git://github.com/tomaszmazur/trixy_scopes.git

in your ActiveRecord model:

<pre>
  class Product < ActiveRecord::Base
    ...
  
    include TrixyScopes
    
  end
</pre>
to gains access to:

## Available named scopes

**limit(*integer*)** - limits result to given number of records

<pre>
Product.limit(5)
# => SELECT * FROM `products` LIMIT 5
</pre>

**random** - adapter agnostic random

<pre>
Product.limit(3).random
# for SQLite adapter
# => SELECT * FROM `sites` ORDER BY RANDOM() LIMIT 3
# for MySql and other adapters:
# => SELECT * FROM `sites` ORDER BY RAND() LIMIT 3
</pre>

**latest(*integer*)** - picks up x latest records (ordered by **created_at**)

<pre>
Product.latest(5)
# => SELECT * FROM `products` ORDER BY `products`.`created_at` desc LIMIT 5
</pre>

**earliest(*integer*)** - picks up x earliest records (ordered by **created_at**)

<pre>
Product.earliest(10)
# => SELECT * FROM `products` ORDER BY `products`.`created_at` asc LIMIT 10
</pre>

**after(*datetime*)** - picks up records after given datetime

<pre>
Product.after(1.year.ago)
# => SELECT * FROM `products` WHERE (`products`.`created_at` > '2008-06-07 16:11:56') 
</pre>

**before(*datetime*)** - picks up records before given datetime

<pre>
Product.before(Time.now.beginning_of_day)
# => SELECT * FROM `products` WHERE (`products`.`created_at` < '2008-06-07 00:00:00') 
</pre>


## ALL column types

**<attribute_name>_is(*attribute_value*)**

<pre>
Author.last_name_is("Smith")
# => SELECT * FROM `authors` WHERE (`authors`.`last_name` = 'Smith')

Product.price_is(19.99)
# => SELECT * FROM `products` WHERE (`products`.`price` = 19.99)
</pre>

**<attribute_name>_is_not(*attribute_value*)**

<pre>
Author.first_name_is_not("John")
# => SELECT * FROM `authors` WHERE (`authors`.`first_name` != 'John')

Product.price_is_not(1_000)
# => SELECT * FROM `products` WHERE (`products`.`price` != 1000)
</pre>

**<attribute_name_plural>_are(*array*)**

<pre>
Product.ids_are(1,2,3)
# => SELECT * FROM `products` WHERE (`products`.`id` IN (1,2,3))

Author.last_names_are("Smith", "Black")
# => SELECT * FROM `authors` WHERE (`authors`.`full_name` IN ('Smith','Black'))
</pre>

**<attribute_name_plural>_are_not(*array*)**

<pre>
Product.prices_are_not(0.99, 5.99, 19.99)
# => SELECT * FROM `products` WHERE (`products`.`id` IN (0.99,5.99,19.99))

Author.first_names_are_not("John", "Mike")
# => SELECT * FROM `authors` WHERE (`authors`.`first_name` IN ('John','Mike'))
</pre>

**<attribute_name>_is_nil**

<pre>
User.full_name_is_nil
# => SELECT * FROM `users` WHERE (`users`.`full_name` IS NULL) 
</pre>

**<attribute_name>_is_not_nil**

<pre>
Product.description_is_not_nil
# => SELECT * FROM `products` WHERE (`products`.`description` IS NOT NULL)
</pre>

## STRING columns

**<attribute_name>_starts_with(*string*)**

<pre>
</pre>

**<attribute_name>_ends_with(*string*)**

<pre>
</pre>

**<attribute_name>_includes(*string*)**

<pre>
</pre>

**<attribute_name>_matches(*regexp*)**

<pre>
</pre>

**<attribute_name>_like(*string*)**

<pre>
</pre>

**<attribute_name>_not_like(*string*)**

<pre>
</pre>

## BOOLEAN

**<attribute_name>**

<pre>
Product.sold
# => SELECT * FROM `products` WHERE (`products`.`sold` = 1)
</pre>

**not_<attribute_name>**

<pre>
Product.not_sold
# => SELECT * FROM `products` WHERE (`products`.`sold` = 0)
</pre>

## DATETIME

**<attribute_name>_before(*datetime*)**

<pre>
</pre>

**<attribute_name>_after(*datetime*)**

<pre>
</pre>

**<attribute_name>_between(*from*, *to*)**

<pre>
Product.created_between('2009-05-01', '2009-05-31')
# => SELECT * FROM `products` WHERE (`products`.`created_at` BETWEEN '2009-05-01' AND '2009-05-31') 

</pre>

**not_<attribute_name>_between(*from*, *to*)**

<pre>
Product.not_created_between('2009-05-01', '2009-05-31')
# => SELECT * FROM `products` WHERE (`products`.`created_at` NOT BETWEEN '2009-05-01' AND '2009-05-31') 
</pre>

## INTEGER, FLOAT

**<attribute_name>_greater_than(*value*)**

<pre>
</pre>

**<attribute_name>_greater_or_equal_to(*value*)**

<pre>
</pre>

**<attribute_name>_less_than(*value*)**

<pre>
</pre>

**<attribute_name>_less_than_or_equal_to(*value*)**

<pre>
</pre>





## Copyright

Copyright (c) 2009 Tomasz Mazur, released under the MIT license
