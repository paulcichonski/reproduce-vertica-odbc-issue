CREATE TABLE public.table1
(
    customer varchar(32),
    field_x char(28)
);

CREATE PROJECTION public.table1_super
(
  customer,
  field_x
)
AS
  SELECT table1.customer,
         table1.field_x
  FROM public.table1
  ORDER BY table1.customer,
           table1.field_x
  SEGMENTED BY hash(table1.customer, table1.field_x)
  ALL NODES OFFSET 0;


INSERT INTO public.table1 VALUES ('customer-01', 'hello world');
INSERT INTO public.table1 VALUES ('customer-02', 'hello world');
COMMIT
