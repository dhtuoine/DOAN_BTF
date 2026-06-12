-- Tạo dữ liệu đơn hàng thật từ file Excel: Tháng 1=40, Tháng 3=60, Tháng 4=70, Tháng 5=80
-- Không insert cột Id, SQL Server sẽ tự tăng Id nên không bị trùng Id giữa các tháng.
-- ShopId/RoomId được lấy luân phiên từ dbo.Shops để dữ liệu không chỉ nằm ở 1 shop.
SET XACT_ABORT ON;
BEGIN TRANSACTION;

IF OBJECT_ID('tempdb..#ShopPool') IS NOT NULL DROP TABLE #ShopPool;
SELECT ROW_NUMBER() OVER (ORDER BY Id) AS rn, Id AS ShopId, RoomId
INTO #ShopPool
FROM dbo.Shops
WHERE RoomId IS NOT NULL;

DECLARE @ShopCount INT = (SELECT COUNT(*) FROM #ShopPool);
IF @ShopCount = 0
BEGIN
    THROW 50001, N'Không có Shop nào trong dbo.Shops để gán cho đơn hàng.', 1;
END

DECLARE @OrderId INT, @ShopId INT, @RoomId INT, @ShopIndex INT;

-- JAN 2026 - đơn 001 - LittleHoopCo
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'JAN2026-001-3947898587')
BEGIN
    SET @ShopIndex = ((1 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'JAN2026-001-3947898587', N'Rachel C Evans', N'+1 555-201-1007', N'5305 Westbridge Rd, Columbus, OH, 43231-4862', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-01-13 09:07:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4165, 1, N'https://www.etsy.com/listing/4432406266/later-alligator-embroidered-baby?transaction_id=4916463086', N'Romper Longer - Cream - 3-6; SL: 1; Custom: no');
END

-- JAN 2026 - đơn 002 - YourEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'JAN2026-002-3943758491')
BEGIN
    SET @ShopIndex = ((2 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'JAN2026-002-3943758491', N'Dahee Van Meeteren', N'+1 555-202-1014', N'3200 Paseo Village Way Apt 1343, San Diego, CA, 92130-3233', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-01-11 10:14:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4202, 1, N'https://www.etsy.com/listing/4436476647/golf-baby-romper-embroidered-golf-theme?transaction_id=4923919551', N'Romper Longer - White - 18-24; SL: 1; Custom: no');
END

-- JAN 2026 - đơn 003 - ProKsais
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'JAN2026-003-3954866044')
BEGIN
    SET @ShopIndex = ((3 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'JAN2026-003-3954866044', N'Anna Wilmesher', N'+1 555-203-1021', N'6124 E Forsee Rd, Ashland, MO, 65010-9296', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-01-26 11:21:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4154, 1, N'https://www.etsy.com/listing/4444631598/first-edition-published-2026-embroidered?transaction_id=4944423961', N'Romper Longer - Cream - 0-3; SL: 1; Custom: no');
END

-- JAN 2026 - đơn 004 - NDV96Store
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'JAN2026-004-3961119883')
BEGIN
    SET @ShopIndex = ((4 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'JAN2026-004-3961119883', N'Marty Squires', N'+1 555-204-1028', N'117 Jennings Court, Radcliff, KY, 40160', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-01-28 12:28:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4225, 1, N'https://www.etsy.com/listing/4444097981/daddys-tiny-striker-baby-romper-soccer?transaction_id=4946235259', N'Romper Short - Coffee - 3-6; SL: 1; Custom: no');
END

-- JAN 2026 - đơn 005 - ÁO_SHOP PQT
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'JAN2026-005-3960518804')
BEGIN
    SET @ShopIndex = ((5 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'JAN2026-005-3960518804', N'Emily wolfarth', N'+1 555-205-1035', N'434 whitetail meadows trail, MARS, PA, 16046', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-01-31 13:35:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4269, 1, N'https://www.etsy.com/listing/4399219527/new-to-the-club-swimming-embroidered?transaction_id=4940051084', N'Bodysuit - Light Pink - 3-6; SL: 1; Lưu ý: Chỉ nâu thay bằng chỉ HỒNG, chọn màu hồng nổi bật được trên áo hồng nhé');
END

-- JAN 2026 - đơn 006 - LittleHoopCo
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'JAN2026-006-3942652678')
BEGIN
    SET @ShopIndex = ((6 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'JAN2026-006-3942652678', N'Sharon Jones', N'+1 555-206-1042', N'253 Deck Valley Lane, Bristol, TN, 37620', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-01-14 14:42:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4154, 1, N'https://www.etsy.com/listing/4395134531/crawl-walk-lift-embroidered-baby?transaction_id=4929985633', N'Romper Longer - Cream - 0-3; SL: 1; Custom: no');
END

-- JAN 2026 - đơn 007 - YourEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'JAN2026-007-3939547656')
BEGIN
    SET @ShopIndex = ((7 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'JAN2026-007-3939547656', N'Kelsey Perry', N'+1 555-207-1049', N'6358 Bradley Rd, Sanford, NC, 27330', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-01-14 15:49:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4164, 1, N'https://www.etsy.com/listing/4432961851/my-daddy-plays-in-the-dirt-baby-romper?transaction_id=4913320884', N'Romper Longer - Dusty Pink - 0-3; SL: 1; Custom: no');
END

-- JAN 2026 - đơn 008 - ProKsais
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'JAN2026-008-3955532838')
BEGIN
    SET @ShopIndex = ((8 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'JAN2026-008-3955532838', N'Mary Cross', N'+1 555-208-1056', N'605 Middle St, Apt 27, Braintree, MA, 02184-5827', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-01-27 16:56:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4165, 1, N'https://www.etsy.com/listing/4444631598/first-edition-published-2026-embroidered?transaction_id=4944423961', N'Romper Longer - Cream - 3-6; SL: 1; Custom: no');
END

-- JAN 2026 - đơn 009 - NDV96Store
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'JAN2026-009-3958755014')
BEGIN
    SET @ShopIndex = ((9 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'JAN2026-009-3958755014', N'Debby Weimer', N'+1 555-209-1063', N'Po Box 107, Ulm, MT, 59485-0107', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-01-30 17:03:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4225, 1, N'https://www.etsy.com/listing/4444107682/little-slam-dunk-baby-romper-basketball?transaction_id=4937783962', N'Romper Short - Coffee - 3-6; SL: 1; Custom: no');
END

-- JAN 2026 - đơn 010 - LittleHoopCo
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'JAN2026-010-3948396887')
BEGIN
    SET @ShopIndex = ((10 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'JAN2026-010-3948396887', N'Agnieszka Gaweł', N'+1 555-210-1070', N'ul. Zięby 40 50, Ursynów, 02-808 Warszawa', N'Poland', @ShopId, @RoomId, N'Hoàn thành', '2026-01-14 08:10:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4268, 1, N'https://www.etsy.com/listing/4418213543/born-to-fly-like-my-daddy-baby-bodysuit?transaction_id=4929902191', N'Bodysuit - Light Blue - 3-6; SL: 1; Custom: no; Lưu ý: IM3720000224');
END

-- JAN 2026 - đơn 011 - YourEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'JAN2026-011-3943537356')
BEGIN
    SET @ShopIndex = ((11 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'JAN2026-011-3943537356', N'Marcy singer', N'+1 555-211-1077', N'4141 Sturgeon Ct, San Diego, CA, 92130-2145', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-01-14 09:17:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4228, 1, N'https://www.etsy.com/listing/4432954535/my-other-car-seat-is-on-the-golf-cart?transaction_id=4931004395', N'Romper Short - Salmon - 3-6; SL: 1; Custom: no');
END

-- JAN 2026 - đơn 012 - ProKsais
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'JAN2026-012-3961303343')
BEGIN
    SET @ShopIndex = ((12 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'JAN2026-012-3961303343', N'Madeleine Mueller', N'+1 555-212-1084', N'13608 Bridgeland Ln, Clifton, VA, 20124-2302', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-01-28 10:24:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4154, 1, N'https://www.etsy.com/listing/4444631598/first-edition-published-2026-embroidered?transaction_id=4935047224', N'Romper Longer - Cream - 0-3; SL: 1; Custom: no');
END

-- JAN 2026 - đơn 013 - NDV96Store
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'JAN2026-013-3963221565')
BEGIN
    SET @ShopIndex = ((13 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'JAN2026-013-3963221565', N'Karen Komer', N'+1 555-213-1091', N'8680 Reserve Lane, Macedonia, OH, 44056', N'United States', @ShopId, @RoomId, N'Chờ thêu', '2026-01-30 11:31:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4174, 1, N'https://www.etsy.com/listing/4444104554/its-in-my-dna-bowling-baby-romper?transaction_id=4937644612', N'Romper Longer - Watermelon - 3-6; SL: 1; Custom: no');
END

-- JAN 2026 - đơn 014 - LittleHoopCo
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'JAN2026-014-3943367176')
BEGIN
    SET @ShopIndex = ((14 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'JAN2026-014-3943367176', N'Melody Mordini', N'+1 555-214-1098', N'1311 Pershing Ave, Wheaton, IL, 60189', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-01-15 12:38:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4266, 1, N'https://www.etsy.com/listing/4427442683/just-hatched-baby-bodysuit-cute?transaction_id=4918180668', N'Bodysuit - Light Pink - 0-3; SL: 1; Custom: no');
END

-- JAN 2026 - đơn 015 - YourEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'JAN2026-015-3950349547')
BEGIN
    SET @ShopIndex = ((15 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'JAN2026-015-3950349547', N'Adrianna Rohani', N'+1 555-215-1105', N'10816 Rockledge View Dr, Riverview, FL, 33579-2366', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-01-16 13:45:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4224, 1, N'https://www.etsy.com/listing/4436466725/custom-name-sailboat-embroidered-romper?transaction_id=4932433079', N'Romper Short - White - 3-6; SL: 1; Custom: Cash');
END

-- JAN 2026 - đơn 016 - ProKsais
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'JAN2026-016-3966473253')
BEGIN
    SET @ShopIndex = ((16 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'JAN2026-016-3966473253', N'Chantal Huerta', N'+1 555-216-1112', N'5425 S 6th Ave, Tucson, AZ, 85706', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-01-28 14:52:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4154, 1, N'https://www.etsy.com/listing/4445823088/its-alright-to-be-a-little-bitty?transaction_id=4953144105', N'Romper Longer - Cream - 0-3; SL: 1; Custom: no');
END

-- JAN 2026 - đơn 017 - NDV96Store
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'JAN2026-017-3964080111')
BEGIN
    SET @ShopIndex = ((17 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'JAN2026-017-3964080111', N'Simone Matzinger', N'+1 555-217-1119', N'Novaragasse 22/13, 1020 Wien', N'Austria', @ShopId, @RoomId, N'Hoàn thành', '2026-01-31 15:59:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4169, 1, N'https://www.etsy.com/listing/4444113376/tiny-touchdown-baby-romper-football?transaction_id=4950064005', N'Romper Longer - White - 3-6; SL: 1; Custom: no; Lưu ý: IM3720000224');
END

-- JAN 2026 - đơn 018 - LittleHoopCo
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'JAN2026-018-3943635044')
BEGIN
    SET @ShopIndex = ((18 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'JAN2026-018-3943635044', N'Shayna Lang', N'+1 555-218-1126', N'224 E Prospect St, Lake Mills, WI, 53551', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-01-15 16:06:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4264, 1, N'https://www.etsy.com/listing/4395092887/my-siblings-have-paws-baby-bodysuit-cute?transaction_id=4918511224', N'Bodysuit - Cream - 0-3; SL: 1; Custom: no');
END

-- JAN 2026 - đơn 019 - YourEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'JAN2026-019-3950354067')
BEGIN
    SET @ShopIndex = ((19 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'JAN2026-019-3950354067', N'Luisa DeSousa', N'+1 555-219-1133', N'5 Sheppard Dr, Warwick, RI, 02886', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-01-16 17:13:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4220, 1, N'https://www.etsy.com/listing/4437040487/music-baby-romper-cant-wait-to-jam-with?transaction_id=4919854232', N'Romper Short - Cream - 3-6; SL: 1; Custom: no');
END

-- JAN 2026 - đơn 020 - LittleHoopCo
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'JAN2026-020-3948694425')
BEGIN
    SET @ShopIndex = ((20 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'JAN2026-020-3948694425', N'Lynn Wygant', N'+1 555-220-1140', N'16023 91st Ave SE, Snohomish, WA, 98296-7003', N'United States', @ShopId, @RoomId, N'Đang thêu', '2026-01-15 08:20:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4268, 1, N'https://www.etsy.com/listing/4424718620/i-yam-cute-baby-bodysuit-funny-sweet?transaction_id=4917592868', N'Bodysuit - Light Blue - 3-6; SL: 1; Custom: no');
END

-- JAN 2026 - đơn 021 - YourEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'JAN2026-021-3952328577')
BEGIN
    SET @ShopIndex = ((21 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'JAN2026-021-3952328577', N'Cheryl Brown', N'+1 555-221-1147', N'2247 Clydeton Rd, Waverly, TN, 37185-3128', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-01-16 09:27:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4170, 1, N'https://www.etsy.com/listing/4432961851/my-daddy-plays-in-the-dirt-baby-romper?transaction_id=4934970985', N'Romper Longer - Coffee - 3-6; SL: 1; Custom: no');
END

-- JAN 2026 - đơn 022 - LittleHoopCo
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'JAN2026-022-3949790457')
BEGIN
    SET @ShopIndex = ((22 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'JAN2026-022-3949790457', N'Sophia Randolph', N'+1 555-222-1154', N'6619 Leland Way, 127.0, Los Angeles, CA, 90028', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-01-16 10:34:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4265, 1, N'https://www.etsy.com/listing/4395636882/milk-monster-embroidered-baby-bodysuit?transaction_id=4931714375', N'Bodysuit - Light Blue - 0-3; SL: 1; Custom: no');
END

-- JAN 2026 - đơn 023 - YourEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'JAN2026-023-3955241949')
BEGIN
    SET @ShopIndex = ((23 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'JAN2026-023-3955241949', N'JoAnn Brown', N'+1 555-223-1161', N'10300 Corona Ave NE, ALBUQUERQUE, NM, 87122', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-01-21 11:41:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4191, 1, N'https://www.etsy.com/listing/4442029176/embroidered-baby-romper-tennis-flower?transaction_id=4926660340', N'Romper Longer - White - 12-18; SL: 1; Custom: no');
END

-- JAN 2026 - đơn 024 - LittleHoopCo
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'JAN2026-024-3947297210')
BEGIN
    SET @ShopIndex = ((24 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'JAN2026-024-3947297210', N'Rachel Howe', N'+1 555-224-1168', N'10 Juniper Close, Reigate, Surrey, RH2 7NQ', N'United Kingdom', @ShopId, @RoomId, N'Hoàn thành', '2026-01-19 12:48:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4264, 1, N'https://www.etsy.com/listing/4395071506/bible-verse-baby-bodysuit-i-am-fearfully?transaction_id=4935476697', N'Bodysuit - Cream - 0-3; SL: 1; Custom: no; Lưu ý: 370 6004 28');
END

-- JAN 2026 - đơn 025 - YourEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'JAN2026-025-3955475793')
BEGIN
    SET @ShopIndex = ((25 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'JAN2026-025-3955475793', N'Kirsten Dorgan', N'+1 555-225-1175', N'12603 Blackthorn Trace, Louisville, KY, 40299', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-01-22 13:55:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4180, 1, N'https://www.etsy.com/listing/4440230726/crawl-walk-snowmobile-baby-romper?transaction_id=4938989535', N'Romper Longer - White - 6-12; SL: 1; Custom: no');
END

-- JAN 2026 - đơn 026 - LittleHoopCo
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'JAN2026-026-3947359142')
BEGIN
    SET @ShopIndex = ((26 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'JAN2026-026-3947359142', N'Kimberly Marino', N'+1 555-226-1182', N'52 High Tower Rd, South Windsor, CT, 06074-1119', N'United States', @ShopId, @RoomId, N'Chờ thêu', '2026-01-19 14:02:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4266, 2, N'https://www.etsy.com/listing/4436929379/little-cutie-embroidered-baby-bodysuit?transaction_id=4935546621', N'Bodysuit - Light Pink - 0-3; SL: 2; Custom: no');
END

-- JAN 2026 - đơn 027 - YourEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'JAN2026-027-0027')
BEGIN
    SET @ShopIndex = ((27 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'JAN2026-027-0027', N'Etsy Customer', N'+1 555-227-1189', N'Etsy order address JAN2026-027-0027', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-01-23 15:09:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4219, 1, N'https://www.etsy.com/listing/4437022788/custom-name-embroidered-baby-romper-new?transaction_id=4940756781', N'Romper Short - Dusty Pink - 0-3; SL: 1; Custom: Dog breed- poodle Name- Stella''s');
END

-- JAN 2026 - đơn 028 - LittleHoopCo
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'JAN2026-028-3949984890')
BEGIN
    SET @ShopIndex = ((28 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'JAN2026-028-3949984890', N'Jeremi Handran', N'+1 555-228-1196', N'904 N Montgomery St, Apt 9, Starkville, MS, 39759-2291', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-01-21 16:16:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4165, 1, N'https://www.etsy.com/listing/4429545030/cute-giraffe-baby-romper-minimal-animal?transaction_id=4938644873', N'Romper Longer - Cream - 3-6; SL: 1; Custom: no');
END

-- JAN 2026 - đơn 029 - YourEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'JAN2026-029-3951724006')
BEGIN
    SET @ShopIndex = ((29 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'JAN2026-029-3951724006', N'Korra Manoleras', N'+1 555-229-1203', N'606 Meadow Lake Dr, Matthews, NC, 28105-0330', N'United States', @ShopId, @RoomId, N'Chưa có áo', '2026-01-23 17:23:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4217, 1, N'https://www.etsy.com/listing/4442026118/future-triathlete-baby-romper-swim-bike?transaction_id=4928835778', N'Romper Short - Salmon - 0-3; SL: 1; Custom: no');
END

-- JAN 2026 - đơn 030 - LittleHoopCo
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'JAN2026-030-3955732061')
BEGIN
    SET @ShopIndex = ((30 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'JAN2026-030-3955732061', N'Kerry Packard', N'+1 555-230-1210', N'52 EVERS ST, AUBURN, MA, 01501', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-01-22 08:30:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4267, 1, N'https://www.etsy.com/listing/4440285195/i-love-yoga-embroidered-baby-bodysuit?transaction_id=4927332782', N'Bodysuit - Cream - 3-6; SL: 1; Custom: no');
END

-- JAN 2026 - đơn 031 - YourEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'JAN2026-031-3953595488')
BEGIN
    SET @ShopIndex = ((31 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'JAN2026-031-3953595488', N'Lorraine Fowler', N'+1 555-231-1217', N'45 Breach Ave, Southbourne, Emsworth, Hants, PO10 8NB', N'United Kingdom', @ShopId, @RoomId, N'Hoàn thành', '2026-01-26 09:37:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4230, 1, N'https://www.etsy.com/listing/4438215259/flying-is-fun-embroidered-baby-romper?transaction_id=4942964849', N'Romper Short - Dusty Pink - 3-6; SL: 1; Custom: no; Lưu ý: 370 6004 28');
END

-- JAN 2026 - đơn 032 - LittleHoopCo
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'JAN2026-032-3956309661')
BEGIN
    SET @ShopIndex = ((32 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'JAN2026-032-3956309661', N'lewis doley', N'+1 555-232-1224', N'11.0, Amphletts Close, Dudley, DY2, 9NZ', N'United Kingdom', @ShopId, @RoomId, N'Hoàn thành', '2026-01-23 10:44:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4265, 1, N'https://www.etsy.com/listing/4396143287/wicked-embroidered-baby-bodysuit?transaction_id=4928122968', N'Bodysuit - Light Blue - 0-3; SL: 1; Custom: no; Lưu ý: 370 6004 28');
END

-- JAN 2026 - đơn 033 - YourEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'JAN2026-033-3960225187')
BEGIN
    SET @ShopIndex = ((33 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'JAN2026-033-3960225187', N'Elizabeth Haskell', N'+1 555-233-1231', N'28 Taft Lane, Morristown, NJ, 07960', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-01-27 11:51:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4263, 1, N'https://www.etsy.com/listing/4436958179/whaley-cute-embroidered-baby-romper-cute?transaction_id=4933574376', N'Romper Short - Dusty Pink - 18-24; SL: 1; Custom: no');
END

-- JAN 2026 - đơn 034 - LittleHoopCo
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'JAN2026-034-3956456025')
BEGIN
    SET @ShopIndex = ((34 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'JAN2026-034-3956456025', N'Meaghan Williams', N'+1 555-234-1238', N'915 W peachtree st NW, Unit 12103, ATLANTA, GA, 30309', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-01-23 12:58:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4267, 1, N'https://www.etsy.com/listing/4418213543/born-to-fly-like-my-daddy-baby-bodysuit?transaction_id=4928319212', N'Bodysuit - Cream - 3-6; SL: 1; Custom: no');
END

-- JAN 2026 - đơn 035 - YourEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'JAN2026-035-3961064123')
BEGIN
    SET @ShopIndex = ((35 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'JAN2026-035-3961064123', N'Terra Mareck Cothran', N'+1 555-235-1245', N'27 Country Classic Circle, Tomball, TX, 77377', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-01-28 13:05:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4173, 1, N'https://www.etsy.com/listing/4432961851/my-daddy-plays-in-the-dirt-baby-romper?transaction_id=4946163151', N'Romper Longer - Salmon - 3-6; SL: 1; Custom: no');
END

-- JAN 2026 - đơn 036 - LittleHoopCo
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'JAN2026-036-3956719171')
BEGIN
    SET @ShopIndex = ((36 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'JAN2026-036-3956719171', N'Elizabeth Quinones', N'+1 555-236-1252', N'15464 Ringbill Way, Magnolia, TX, 77354-7181', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-01-23 14:12:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4268, 1, N'https://www.etsy.com/listing/4441941191/im-adora-bao-embroidered-baby-bodysuit?transaction_id=4928647802', N'Bodysuit - Light Blue - 3-6; SL: 1; Custom: no');
END

-- JAN 2026 - đơn 037 - YourEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'JAN2026-037-3957900644')
BEGIN
    SET @ShopIndex = ((37 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'JAN2026-037-3957900644', N'Tracy Myers', N'+1 555-237-1259', N'6003 Percheron Trail, Summerfield, NC, 27358', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-01-29 15:19:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4177, 1, N'https://www.etsy.com/listing/4437038588/soccer-baby-romper-future-goal-getter?transaction_id=4936703400', N'Romper Longer - Sage Green - 6-12; SL: 1; Custom: no');
END

-- JAN 2026 - đơn 038 - LittleHoopCo
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'JAN2026-038-3958657505')
BEGIN
    SET @ShopIndex = ((38 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'JAN2026-038-3958657505', N'Gina zarski', N'+1 555-238-1266', N'Fliegergasse 52, 2700 Wiener Neustadt', N'Austria', @ShopId, @RoomId, N'Hoàn thành', '2026-01-26 16:26:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4265, 1, N'https://www.etsy.com/listing/4418213543/born-to-fly-like-my-daddy-baby-bodysuit?transaction_id=4931345472', N'Bodysuit - Light Blue - 0-3; SL: 1; Custom: no');
END

-- JAN 2026 - đơn 039 - YourEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'JAN2026-039-3962544867')
BEGIN
    SET @ShopIndex = ((39 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'JAN2026-039-3962544867', N'Kristlyn Brinkley', N'+1 555-239-1273', N'611 Wakefield Ct, 102.0, Long Beach, CA, 90803', N'United States', @ShopId, @RoomId, N'Chờ thêu', '2026-01-29 17:33:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4187, 1, N'https://www.etsy.com/listing/4432968408/olive-you-embroidered-baby-romper-cute?transaction_id=4936731228', N'Romper Longer - Cream - 12-18; SL: 1; Custom: no');
END

-- JAN 2026 - đơn 040 - LittleHoopCo
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'JAN2026-040-3960585735')
BEGIN
    SET @ShopIndex = ((40 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'JAN2026-040-3960585735', N'angela hill', N'+1 555-240-1280', N'7367 Platt Springs Rd, Lexington, SC, 29073', N'United States', @ShopId, @RoomId, N'Đang thêu', '2026-01-27 08:40:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4266, 1, N'https://www.etsy.com/listing/4424718620/i-yam-cute-baby-bodysuit-funny-sweet?transaction_id=4945537047', N'Bodysuit - Light Pink - 0-3; SL: 1; Custom: no');
END

-- MAR 2026 - đơn 001 - ViviEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-001-3987980238')
BEGIN
    SET @ShopIndex = ((41 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-001-3987980238', N'Zoe Hancock', N'+1 555-241-1287', N'15 Titchener Row, Stanford in the Vale Oxfordshire', N'United Kingdom', @ShopId, @RoomId, N'Hoàn thành', '2026-03-01 09:07:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4213, 1, N'https://www.etsy.com/ca/listing/4392936688/shhh-im-watching-motogp-with-daddy?transaction_id=4985057741', N'Romper Short - White - 0-3; SL: 1; Custom: no; Lưu ý: 370 6004 28');
END

-- MAR 2026 - đơn 002 - ÁO_SHOP EmbroiWithCare
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-002-3987385362')
BEGIN
    SET @ShopIndex = ((42 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-002-3987385362', N'Rhonda Brown', N'+1 555-242-1294', N'15436 130th St, foreston, MN, 56330', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-03-01 10:14:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4168, 1, N'https://www.etsy.com/listing/4321796572/i-love-my-custom-name-embroidered-romper?transaction_id=4984334861', N'Romper Longer - Mauve Taupe - 3-6; SL: 1; Custom: Gammy');
END

-- MAR 2026 - đơn 003 - ÁO_SHOP PQT
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-003-3991635845')
BEGIN
    SET @ShopIndex = ((43 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-003-3991635845', N'Nolan and Sarah Ramos', N'+1 555-243-1301', N'4132 Fir St SW, Mcchord Afb, WA, 98439-1616', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-03-01 11:21:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4166, 1, N'https://www.etsy.com/listing/4446339261/personalized-penguin-baby-romper-custom?transaction_id=4975464108', N'Romper Longer - Sage Green - 3-6; SL: 1; Custom: Grayson');
END

-- MAR 2026 - đơn 004 - ÁO_SHOP_A.KHAI
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-004-3988141506')
BEGIN
    SET @ShopIndex = ((44 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-004-3988141506', N'Mary Zipf', N'+1 555-244-1308', N'12032 SE Birkdale Run, Jupiter, FL, 33469', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-03-02 12:28:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4268, 1, N'https://www.etsy.com/listing/4435908861/personalized-little-putter-golf?transaction_id=4974976348', N'Bodysuit - Light Blue - 3-6; SL: 1');
END

-- MAR 2026 - đơn 005 - NDV96Store
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-005-3991597791')
BEGIN
    SET @ShopIndex = ((45 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-005-3991597791', N'Carol Williams', N'+1 555-245-1315', N'4991 Spanish Oak Rd, Douglasville, GA, 30135', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-03-01 13:35:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4154, 1, N'https://www.etsy.com/listing/4454899012/apparently-i-like-baseball-baby-romper?transaction_id=4975418242', N'Romper Longer - Cream - 0-3; SL: 1; Custom: no');
END

-- MAR 2026 - đơn 006 - ProKsais
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-006-3988694550')
BEGIN
    SET @ShopIndex = ((46 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-006-3988694550', N'Jeri Cliff', N'+1 555-246-1322', N'7 Grasslands Trl, Santa Fe, NM, 87508-1316', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-03-01 14:42:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4268, 1, N'https://www.etsy.com/listing/4445821812/yes-im-treble-embroidered-baby-bodysuit?transaction_id=4986023643', N'Bodysuit - Light Blue - 3-6; SL: 1; Custom: no');
END

-- MAR 2026 - đơn 007 - LittleHoopCo
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-007-3988655562')
BEGIN
    SET @ShopIndex = ((47 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-007-3988655562', N'Pamela Battinelli', N'+1 555-247-1329', N'92 RIVER ST, NORTH WEYMOUTH, MA, 02191', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-03-01 15:49:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4266, 1, N'https://www.etsy.com/listing/4395674850/new-chick-in-town-baby-bodysuit?transaction_id=4975630376', N'Bodysuit - Light Pink - 0-3; SL: 1; Custom: no');
END

-- MAR 2026 - đơn 008 - YourEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-008-4004105870')
BEGIN
    SET @ShopIndex = ((48 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-008-4004105870', N'Isabella Yermolov', N'+1 555-248-1336', N'1405 14th Ter, Palm Beach Gardens, FL, 33418-3612', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-03-17 16:56:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4246, 1, N'https://www.etsy.com/listing/4436466725/custom-name-sailboat-embroidered-romper?transaction_id=5005373963', N'Romper Short - White - 12-18; SL: 1; Custom: Jason');
END

-- MAR 2026 - đơn 009 - ÁO_MottolaMind
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-009-3996577119')
BEGIN
    SET @ShopIndex = ((49 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-009-3996577119', N'Ruth Barnes', N'+1 555-249-1343', N'10044 Deer Creek Street, Highlands Ranch, CO, 80129-6503', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-03-07 17:03:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4162, 1, N'https://www.etsy.com/listing/4463233979/little-sister-baby-romper-custom-name?transaction_id=4992179403', N'Romper Longer - Salmon - 0-3; SL: 1');
END

-- MAR 2026 - đơn 010 - Tramembroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-010-3997663716')
BEGIN
    SET @ShopIndex = ((50 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-010-3997663716', N'Jenna Mills', N'+1 555-250-1350', N'50529 Jefferson St, Canton, MI, 48188', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-03-10 08:10:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4209, 1, N'https://www.etsy.com/ca/listing/4451695034/my-first-racing-season-baby-romper?transaction_id=4996986907', N'Romper Short - Cream - 0-3; SL: 1; Custom: no');
END

-- MAR 2026 - đơn 011 - ViviEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-011-3988069772')
BEGIN
    SET @ShopIndex = ((51 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-011-3988069772', N'Patricia Whitener', N'+1 555-251-1357', N'182 Lay Bridge rd, Central, SC, 29630', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-03-01 09:17:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4165, 1, N'https://www.etsy.com/ca/listing/4376389783/player-2-baby-romper-gamer-baby-outfit?transaction_id=4974885752', N'Romper Longer - Cream - 3-6; SL: 1; Custom: no');
END

-- MAR 2026 - đơn 012 - ÁO_SHOP EmbroiWithCare
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-012-3990544421')
BEGIN
    SET @ShopIndex = ((52 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-012-3990544421', N'Jessi Schoenleber', N'+1 555-252-1364', N'5 Valley Court, Cream Ridge, NJ, 08514', N'United States', @ShopId, @RoomId, N'Chờ thêu', '2026-03-01 10:24:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4220, 1, N'https://www.etsy.com/listing/4336892730/funny-golf-baby-romper-apparently-i-like?transaction_id=4974036294', N'Romper Short - Cream - 3-6; SL: 1');
END

-- MAR 2026 - đơn 013 - ÁO_SHOP PQT
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-013-3993441422')
BEGIN
    SET @ShopIndex = ((53 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-013-3993441422', N'Christina Halvorson', N'+1 555-253-1371', N'204 W 9th St, LIBBY, MT, 59923-1877', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-03-06 11:31:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4154, 1, N'https://www.etsy.com/listing/4418854736/i-cant-wait-to-jam-with-daddy-piano?transaction_id=4992139039', N'Romper Longer - Cream - 0-3; SL: 1');
END

-- MAR 2026 - đơn 014 - ÁO_SHOP_A.KHAI
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-014-3989867219')
BEGIN
    SET @ShopIndex = ((54 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-014-3989867219', N'Melissa Eales', N'+1 555-254-1378', N'5 Ashford Street, Shorncliffe QLD 4017', N'Australia', @ShopId, @RoomId, N'Hoàn thành', '2026-03-02 12:38:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4268, 1, N'https://www.etsy.com/listing/4437043955/new-to-the-crew-running-embroidered-baby?transaction_id=4983483929', N'Bodysuit - Light Blue - 3-6; SL: 1');
END

-- MAR 2026 - đơn 015 - NDV96Store
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-015-3992237403')
BEGIN
    SET @ShopIndex = ((55 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-015-3992237403', N'Kaylah C', N'+1 555-255-1385', N'300 Prominence Point Pkwy, Apt 1102, Canton, GA, 30114', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-03-02 13:45:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4231, 1, N'https://www.etsy.com/listing/4446342577/assistant-coach-embroidered-baby-romper?transaction_id=4986576239', N'Romper Short - Cream - 6-12; SL: 1; Custom: no');
END

-- MAR 2026 - đơn 016 - ProKsais
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-016-3992705895')
BEGIN
    SET @ShopIndex = ((56 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-016-3992705895', N'BETH ROJACK', N'+1 555-256-1392', N'40 HILLCREST RD, MADISON, NJ, 07940-2504', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-03-02 14:52:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4165, 1, N'https://www.etsy.com/listing/4444631598/first-edition-published-2026-embroidered?transaction_id=4976696854', N'Romper Longer - Cream - 3-6; SL: 1; Custom: no');
END

-- MAR 2026 - đơn 017 - LittleHoopCo
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-017-3990154326')
BEGIN
    SET @ShopIndex = ((57 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-017-3990154326', N'Jenny Schick', N'+1 555-257-1399', N'Graf-Heinrich-Ring 11, Nünschweiler, 66989', N'Germany', @ShopId, @RoomId, N'Hoàn thành', '2026-03-01 15:59:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4165, 1, N'https://www.etsy.com/listing/4395656915/cute-little-raspberry-embroidered-baby?transaction_id=4988145785', N'Romper Longer - Cream - 3-6; SL: 1; Custom: no');
END

-- MAR 2026 - đơn 018 - YourEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-018-4004463884')
BEGIN
    SET @ShopIndex = ((58 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-018-4004463884', N'Patricia Giordano', N'+1 555-258-1406', N'29 Hamilton Street, Madison, NJ, 07940', N'United States', @ShopId, @RoomId, N'Chưa có áo', '2026-03-18 16:06:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4166, 1, N'https://www.etsy.com/listing/4436466725/custom-name-sailboat-embroidered-romper?transaction_id=5005817105', N'Romper Longer - Sage Green - 3-6; SL: 1; Custom: Grayson');
END

-- MAR 2026 - đơn 019 - ÁO_MottolaMind
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-019-3993627254')
BEGIN
    SET @ShopIndex = ((59 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-019-3993627254', N'Mackenzie OBRIEN', N'+1 555-259-1413', N'1039 57th St, Unit Downstairs, Emeryville, CA, 94608', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-03-09 17:13:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4239, 1, N'https://www.etsy.com/listing/4463219999/little-sprout-baby-romper-custom-name?transaction_id=4981971934', N'Romper Short - Salmon - 6-12; SL: 1');
END

-- MAR 2026 - đơn 020 - Tramembroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-020-3999506674')
BEGIN
    SET @ShopIndex = ((60 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-020-3999506674', N'Courtney Medack', N'+1 555-260-1420', N'1910 Branch Creek Dr, Longview, WA, 98632', N'United States', @ShopId, @RoomId, N'Đang thêu', '2026-03-12 08:20:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4178, 1, N'https://www.etsy.com/ca/listing/4470615480/apparently-i-like-f1-baby-romper-formula?transaction_id=4989437094', N'Romper Longer - Caldet Blue - 6-12; SL: 1; Custom: N/A');
END

-- MAR 2026 - đơn 021 - ViviEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-021-3988118622')
BEGIN
    SET @ShopIndex = ((61 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-021-3988118622', N'Debra Brandt', N'+1 555-261-1427', N'661 Bross St, CAIRO, NY, 12413', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-03-01 09:27:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4178, 1, N'https://www.etsy.com/ca/listing/4346129239/soccer-baby-romper-embroidered-daddy-and?transaction_id=4985239049', N'Romper Longer - Caldet Blue - 6-12; SL: 1; Custom: Can this be changed to say mommy instead of daddy?');
END

-- MAR 2026 - đơn 022 - ÁO_SHOP EmbroiWithCare
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-022-3990614805')
BEGIN
    SET @ShopIndex = ((62 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-022-3990614805', N'Shawntale Tingle', N'+1 555-262-1434', N'2326 Indiana Ave, Madison, IN, 47250', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-03-01 10:34:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4225, 1, N'https://www.etsy.com/listing/4321796572/i-love-my-custom-name-embroidered-romper?transaction_id=4974132182', N'Romper Short - Coffee - 3-6; SL: 1; Custom: Nay Nay');
END

-- MAR 2026 - đơn 023 - ÁO_SHOP PQT
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-023-3996238447')
BEGIN
    SET @ShopIndex = ((63 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-023-3996238447', N'Antonia-Rozalia Moser', N'+1 555-263-1441', N'Am Sonnenhang 21, Kürnach, 97273', N'Germany', @ShopId, @RoomId, N'Hoàn thành', '2026-03-06 11:41:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4154, 1, N'https://www.etsy.com/listing/4404016464/player-3-has-entered-the-game?transaction_id=4991729967', N'Romper Longer - Cream - 0-3; SL: 1');
END

-- MAR 2026 - đơn 024 - ÁO_SHOP_A.KHAI
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-024-3990257013')
BEGIN
    SET @ShopIndex = ((64 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-024-3990257013', N'Michael Mosher', N'+1 555-264-1448', N'25 Cornell Dr, East Brunswick, NJ, 08816-5316', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-03-02 12:48:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4266, 1, N'https://www.etsy.com/listing/4430822725/personalized-little-cutie-baby-bodysuit?transaction_id=4973648794', N'Bodysuit - Light Pink - 0-3; SL: 1');
END

-- MAR 2026 - đơn 025 - NDV96Store
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-025-3992570645')
BEGIN
    SET @ShopIndex = ((65 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-025-3992570645', N'Daisy Robledo', N'+1 555-265-1455', N'811 Scarlett Pl, Tracy, CA, 95376', N'United States', @ShopId, @RoomId, N'Chờ thêu', '2026-03-02 13:55:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4209, 1, N'https://www.etsy.com/listing/4448380248/see-you-on-the-court-baby-romper?transaction_id=4986999317', N'Romper Short - Cream - 0-3; SL: 1; Custom: no');
END

-- MAR 2026 - đơn 026 - ProKsais
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-026-3997684064')
BEGIN
    SET @ShopIndex = ((66 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-026-3997684064', N'Melissa Vitort', N'+1 555-266-1462', N'232 Joe''s Court, Junction City, WI, 54443', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-03-10 14:02:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4165, 1, N'https://www.etsy.com/listing/4445823088/its-alright-to-be-a-little-bitty?transaction_id=4997012411', N'Romper Longer - Cream - 3-6; SL: 1; Custom: no');
END

-- MAR 2026 - đơn 027 - LittleHoopCo
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-027-3992563519')
BEGIN
    SET @ShopIndex = ((67 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-027-3992563519', N'Patti Wilson', N'+1 555-267-1469', N'396 Domanski Road, RR 1 RMB 124, Fort Frances, ON, P9A 3M2', N'Canada', @ShopId, @RoomId, N'Hoàn thành', '2026-03-01 15:09:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4264, 1, N'https://www.etsy.com/listing/4441957184/happy-camper-embroidered-baby-bodysuit?transaction_id=4976543850', N'Bodysuit - Cream - 0-3; SL: 1; Custom: no');
END

-- MAR 2026 - đơn 028 - YourEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-028-4004792048')
BEGIN
    SET @ShopIndex = ((68 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-028-4004792048', N'Melissa DiBernardino', N'+1 555-268-1476', N'708 Oakbourne Rd, 1.0, West Chester, PA, 19382', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-03-18 16:16:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4231, 1, N'https://www.etsy.com/listing/4432968408/olive-you-embroidered-baby-romper-cute?transaction_id=5006239025', N'Romper Short - Cream - 6-12; SL: 1; Custom: no');
END

-- MAR 2026 - đơn 029 - ÁO_MottolaMind
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-029-3996196802')
BEGIN
    SET @ShopIndex = ((69 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-029-3996196802', N'Lauren McDonald', N'+1 555-269-1483', N'701 Hook Dr, Salem, KY, 42078-8023', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-03-10 17:23:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4164, 1, N'https://www.etsy.com/listing/4463237615/new-to-the-club-baby-romper-custom-name?transaction_id=4995186385', N'Romper Longer - Dusty Pink - 0-3; SL: 1');
END

-- MAR 2026 - đơn 030 - Tramembroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-030-4010000298')
BEGIN
    SET @ShopIndex = ((70 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-030-4010000298', N'Darren McGonigle', N'+1 555-270-1490', N'8356 Arracourt Way, Fort Benning, GA, 31905-7093', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-03-24 08:30:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4213, 1, N'https://www.etsy.com/ca/listing/4470615480/apparently-i-like-f1-baby-romper-formula?transaction_id=5003043950', N'Romper Short - White - 0-3; SL: 1; Custom: no name please - just the “apparently I like F1” with the car :) thank you!');
END

-- MAR 2026 - đơn 031 - ViviEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-031-3988611844')
BEGIN
    SET @ShopIndex = ((71 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-031-3988611844', N'Kate Lyons', N'+1 555-271-1497', N'12701 Lowden Lane Suite 301, RBC1207-5, Manchaca, TX, 78652', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-03-01 09:37:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4209, 1, N'https://www.etsy.com/ca/listing/4330485404/cat-face-embroidered-baby-romper-funny?transaction_id=4975575138', N'Romper Short - Cream - 0-3; SL: 1; Custom: no');
END

-- MAR 2026 - đơn 032 - ÁO_SHOP EmbroiWithCare
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-032-3990906907')
BEGIN
    SET @ShopIndex = ((72 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-032-3990906907', N'Lauren Portalez', N'+1 555-272-1504', N'1811 Newsom Mound Road, SPRINGTOWN, TX, 76082', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-03-01 10:44:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4165, 1, N'https://www.etsy.com/listing/4321796572/i-love-my-custom-name-embroidered-romper?transaction_id=4974132182', N'Romper Longer - Cream - 3-6; SL: 1; Custom: TIA LAUREN');
END

-- MAR 2026 - đơn 033 - ÁO_SHOP PQT
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-033-3996720263')
BEGIN
    SET @ShopIndex = ((73 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-033-3996720263', N'Allyson Tiojanco', N'+1 555-273-1511', N'129 Lugo Lane, Mission Viejo, CA, 92692', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-03-06 11:51:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4154, 1, N'https://www.etsy.com/listing/4442578117/our-littlest-love-embroidered-baby?transaction_id=4982005364', N'Romper Longer - Cream - 0-3; SL: 1');
END

-- MAR 2026 - đơn 034 - ÁO_SHOP_A.KHAI
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-034-3990439604')
BEGIN
    SET @ShopIndex = ((74 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-034-3990439604', N'anthony williams', N'+1 555-274-1518', N'600 county road 2906, mineola, TX, 75773', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-03-05 12:58:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4267, 1, N'https://www.etsy.com/listing/4462705441/small-family-mushroom-embroidered-baby?transaction_id=4988543783', N'Bodysuit - Cream - 3-6; SL: 1');
END

-- MAR 2026 - đơn 035 - NDV96Store
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-035-3990994066')
BEGIN
    SET @ShopIndex = ((75 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-035-3990994066', N'Brooke kreuser', N'+1 555-275-1525', N'1915 32nd Street Kenosha Wisconsin, Kenosha, WI, 53140', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-03-04 13:05:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4159, 1, N'https://www.etsy.com/listing/4451626020/my-first-racing-season-embroidered-baby?transaction_id=4989285119', N'Romper Longer - Coffee - 0-3; SL: 1; Custom: no');
END

-- MAR 2026 - đơn 036 - ProKsais
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-036-4000146517')
BEGIN
    SET @ShopIndex = ((76 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-036-4000146517', N'Roshalle Johnson', N'+1 555-276-1532', N'1261 Calzada Avenue, Santa Ynez, CA, 93460', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-03-10 14:12:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4154, 1, N'https://www.etsy.com/listing/4451637630/construction-truck-embroidered-baby?transaction_id=4996874413', N'Romper Longer - Cream - 0-3; SL: 1; Custom: no');
END

-- MAR 2026 - đơn 037 - LittleHoopCo
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-037-3998453744')
BEGIN
    SET @ShopIndex = ((77 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-037-3998453744', N'Ida Giardini', N'+1 555-277-1539', N'50 Rue Joseph De Maistre, 5eme etage, Paris, 75018', N'France', @ShopId, @RoomId, N'Hoàn thành', '2026-03-11 15:19:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4165, 1, N'https://www.etsy.com/listing/4429463247/born-to-ride-with-my-daddy-baby-romper?transaction_id=4988079994', N'Romper Longer - Cream - 3-6; SL: 1; Custom: no; Lưu ý: IM3720000224');
END

-- MAR 2026 - đơn 038 - YourEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-038-0038')
BEGIN
    SET @ShopIndex = ((78 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-038-0038', N'Etsy Customer', N'+1 555-278-1546', N'Etsy order address MAR2026-038-0038', N'United States', @ShopId, @RoomId, N'Chờ thêu', '2026-03-19 16:26:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4233, 1, N'https://www.etsy.com/listing/4435899921/clean-up-crew-baby-romper-cute-puppy?transaction_id=4997522262', N'Romper Short - Caldet Blue - 6-12; SL: 1; Custom: no');
END

-- MAR 2026 - đơn 039 - ÁO_MottolaMind
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-039-3999035435')
BEGIN
    SET @ShopIndex = ((79 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-039-3999035435', N'Jonathan Romero', N'+1 555-279-1553', N'200 S Ash St, Unit A, Conway, AR, 72033', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-03-10 17:33:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4165, 1, N'https://www.etsy.com/listing/4463237615/new-to-the-club-baby-romper-custom-name?transaction_id=4985456738', N'Romper Longer - Cream - 3-6; SL: 1');
END

-- MAR 2026 - đơn 040 - Tramembroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-040-4015263279')
BEGIN
    SET @ShopIndex = ((80 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-040-4015263279', N'Sasha Audet', N'+1 555-280-1560', N'1225 Rue Des Tourterelles, Longueuil QC J4G 2J2, Canada', N'+1 819-588-5150', @ShopId, @RoomId, N'Đang thêu', '2026-03-29 08:40:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4211, 1, N'https://www.etsy.com/ca/listing/4470615480/apparently-i-like-f1-baby-romper-formula?transaction_id=5016427093', N'Romper Short - Caldet Blue - 0-3; SL: 1; Custom: Arnaud ( viết tên xuống dưới cái xe)');
END

-- MAR 2026 - đơn 041 - ViviEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-041-3988769098')
BEGIN
    SET @ShopIndex = ((81 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-041-3988769098', N'Linnie Kazer', N'+1 555-281-1567', N'14400 Glen Manor Dr, Apt 313, Chantilly, VA, 20151-1837', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-03-01 09:47:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4242, 1, N'https://www.etsy.com/ca/listing/4376392339/funny-baby-romper-my-brand-of-formula?transaction_id=4975776012', N'Romper Short - Cream - 12-18; SL: 1; Custom: no');
END

-- MAR 2026 - đơn 042 - ÁO_SHOP EmbroiWithCare
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-042-3990927773')
BEGIN
    SET @ShopIndex = ((82 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-042-3990927773', N'Sarah Johnson', N'+1 555-282-1574', N'280 El Sereno Drive, Scotts Valley, CA, 95066', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-03-01 10:54:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4154, 1, N'https://www.etsy.com/listing/4336892730/funny-golf-baby-romper-apparently-i-like?transaction_id=4974578414', N'Romper Longer - Cream - 0-3; SL: 1');
END

-- MAR 2026 - đơn 043 - ÁO_SHOP PQT
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-043-3994218412')
BEGIN
    SET @ShopIndex = ((83 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-043-3994218412', N'Nina Ward', N'+1 555-283-1581', N'6001 S Congress Ave, Apt 1329, AUSTIN, TX, 78745-2035', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-03-07 11:01:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4266, 1, N'https://www.etsy.com/listing/4447378305/opal-personalized-shell-embroidered-baby?transaction_id=4992982855', N'Bodysuit - Light Pink - 0-3; SL: 1; Custom: Liliana');
END

-- MAR 2026 - đơn 044 - ÁO_SHOP_A.KHAI
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-044-3990525480')
BEGIN
    SET @ShopIndex = ((84 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-044-3990525480', N'Samantha Palazzolo', N'+1 555-284-1588', N'44381 Apple Blossom Drive, Sterling Heights, MI, 48314', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-03-05 12:08:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4265, 1, N'https://www.etsy.com/listing/4430837644/personalized-new-to-the-crew-baby?transaction_id=4978050446', N'Bodysuit - Light Blue - 0-3; SL: 1');
END

-- MAR 2026 - đơn 045 - NDV96Store
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-045-0045')
BEGIN
    SET @ShopIndex = ((85 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-045-0045', N'Etsy Customer', N'+1 555-285-1595', N'Etsy order address MAR2026-045-0045', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-03-05 13:15:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4160, 1, N'https://www.etsy.com/listing/4461651558/custom-name-shamrock-embroidered-romper?transaction_id=4990588095', N'Romper Longer - Forest Green - 0-3; SL: 1; Custom: Lucky #7');
END

-- MAR 2026 - đơn 046 - ProKsais
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-046-3997980464')
BEGIN
    SET @ShopIndex = ((86 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-046-3997980464', N'Brittany Snook', N'+1 555-286-1602', N'128 Grove st, Poultney, VT, 05764', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-03-11 14:22:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4165, 1, N'https://www.etsy.com/listing/4445837519/cant-wait-to-jam-with-daddy-embroidered?transaction_id=4987483098', N'Romper Longer - Cream - 3-6; SL: 1; Custom: no');
END

-- MAR 2026 - đơn 047 - LittleHoopCo
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-047-4001197009')
BEGIN
    SET @ShopIndex = ((87 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-047-4001197009', N'Melodie Duke', N'+1 555-287-1609', N'54277 Oakhill, La Quinta, CA, 92253', N'United States', @ShopId, @RoomId, N'Chưa có áo', '2026-03-11 15:29:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4267, 1, N'https://www.etsy.com/listing/4426076480/golf-baby-bodysuit-funny-embroidered?transaction_id=4998254197', N'Bodysuit - Cream - 3-6; SL: 1; Custom: no');
END

-- MAR 2026 - đơn 048 - YourEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-048-4008337639')
BEGIN
    SET @ShopIndex = ((88 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-048-4008337639', N'Beth Parker', N'+1 555-288-1616', N'303 N Grove St, BOWLING GREEN, OH, 43402-2323', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-03-19 16:36:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4183, 1, N'https://www.etsy.com/listing/4435899921/clean-up-crew-baby-romper-cute-puppy?transaction_id=5007479309', N'Romper Longer - Texas Orange - 6-12; SL: 1; Custom: no');
END

-- MAR 2026 - đơn 049 - ÁO_MottolaMind
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-049-4009945912')
BEGIN
    SET @ShopIndex = ((89 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-049-4009945912', N'Lisa Bergen', N'+1 555-289-1623', N'Bödekerstraße 21, Osnabrück, 49080', N'Germany', @ShopId, @RoomId, N'Hoàn thành', '2026-03-25 17:43:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4228, 1, N'https://www.etsy.com/listing/4473230310/future-metalhead-baby-romper-custom-name?transaction_id=5012691249', N'Romper Short - Salmon - 3-6; SL: 1');
END

-- MAR 2026 - đơn 050 - Tramembroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-050-4016795451')
BEGIN
    SET @ShopIndex = ((90 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-050-4016795451', N'Alyssa Rodriguez', N'+1 555-290-1630', N'4800 Auburn Ave, Bethesda, MD, 20814-4057', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-03-29 08:50:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4222, 1, N'https://www.etsy.com/ca/listing/4470615480/apparently-i-like-f1-baby-romper-formula?transaction_id=5008484496', N'Romper Short - Caldet Blue - 3-6; SL: 1; Custom: Atticus ( viết tên xuống dưới cái xe)');
END

-- MAR 2026 - đơn 051 - ViviEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-051-3991090143')
BEGIN
    SET @ShopIndex = ((91 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-051-3991090143', N'Rachel E Markley', N'+1 555-291-1637', N'1052 Brannons Ford Rd, Gerrardstown, WV, 25420', N'United States', @ShopId, @RoomId, N'Chờ thêu', '2026-03-01 09:57:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4165, 1, N'https://www.etsy.com/ca/listing/4372352286/silly-goose-baby-romper-funny-infant?transaction_id=4974806714', N'Romper Longer - Cream - 3-6; SL: 1; Custom: no');
END

-- MAR 2026 - đơn 052 - ÁO_SHOP EmbroiWithCare
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-052-0052')
BEGIN
    SET @ShopIndex = ((92 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-052-0052', N'------------------------------', N'+1 555-292-1644', N'------------------------------', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-03-01 10:04:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4231, 1, N'-----------------------------', N'Romper Short - Cream - 6-12; SL: 1');
END

-- MAR 2026 - đơn 053 - ÁO_SHOP PQT
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-053-3997371047')
BEGIN
    SET @ShopIndex = ((93 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-053-3997371047', N'Jeanne Turner', N'+1 555-293-1651', N'1332 Rock Point Rd, CHARLOTTE, NC, 28270', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-03-07 11:11:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4268, 1, N'https://www.etsy.com/listing/4421467286/daddys-future-buddy-french-horn-romper?transaction_id=4983009442', N'Bodysuit - Light Blue - 3-6; SL: 1');
END

-- MAR 2026 - đơn 054 - ÁO_SHOP_A.KHAI
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-054-3994368933')
BEGIN
    SET @ShopIndex = ((94 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-054-3994368933', N'ellen hannen', N'+1 555-294-1658', N'16 mine brook road, colts neck, NJ, 07722', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-03-05 12:18:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4266, 1, N'https://www.etsy.com/listing/4430837644/personalized-new-to-the-crew-baby?transaction_id=4989281515', N'Bodysuit - Light Pink - 0-3; SL: 1');
END

-- MAR 2026 - đơn 055 - NDV96Store
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-055-3991829128')
BEGIN
    SET @ShopIndex = ((95 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-055-3991829128', N'AJ DeBruin', N'+1 555-295-1665', N'N7470 County Rd CJ, Plymouth, WI, 53073', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-03-05 13:25:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4181, 1, N'https://www.etsy.com/listing/4451626020/my-first-racing-season-embroidered-baby?transaction_id=4990292723', N'Romper Longer - Coffee - 6-12; SL: 1; Custom: no');
END

-- MAR 2026 - đơn 056 - ProKsais
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-056-4003054211')
BEGIN
    SET @ShopIndex = ((96 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-056-4003054211', N'Julie Winans', N'+1 555-296-1672', N'9030 9th Pl SE, LAKE STEVENS, WA, 98258', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-03-13 14:32:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4165, 1, N'https://www.etsy.com/listing/4445837519/cant-wait-to-jam-with-daddy-embroidered?transaction_id=4990699690', N'Romper Longer - Cream - 3-6; SL: 1; Custom: no');
END

-- MAR 2026 - đơn 057 - LittleHoopCo
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-057-4001704371')
BEGIN
    SET @ShopIndex = ((97 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-057-4001704371', N'Alexander Berns', N'+1 555-297-1679', N'Hildeboldstr. 1, Frechen, 50226', N'Germany', @ShopId, @RoomId, N'Hoàn thành', '2026-03-12 15:39:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4268, 1, N'https://www.etsy.com/listing/4426098822/daddy-lifting-buddy-baby-bodysuit-funny?transaction_id=4998911687', N'Bodysuit - Light Blue - 3-6; SL: 1; Custom: no; Lưu ý: IM3720000224');
END

-- MAR 2026 - đơn 058 - YourEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-058-4009233879')
BEGIN
    SET @ShopIndex = ((98 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-058-4009233879', N'Dawn Riner', N'+1 555-298-1686', N'2400 State Hwy 199, ARDMORE, OK, 73401', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-03-20 16:46:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4230, 1, N'https://www.etsy.com/listing/4432961851/my-daddy-plays-in-the-dirt-baby-romper?transaction_id=4998711516', N'Romper Short - Dusty Pink - 3-6; SL: 1; Custom: no');
END

-- MAR 2026 - đơn 059 - ÁO_MottolaMind
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-059-4009971628')
BEGIN
    SET @ShopIndex = ((99 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-059-4009971628', N'Sarah Wyand', N'+1 555-299-1693', N'7147 E Lake Ct, Perrysburg, OH, 43551', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-03-25 17:53:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4213, 2, N'https://www.etsy.com/listing/4473218593/everleigh-cherry-baby-romper-custom-name?transaction_id=5003007546', N'Romper Short - White - 0-3; SL: 2; Custom: Cherry Street Girl');
END

-- MAR 2026 - đơn 060 - Tramembroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAR2026-060-4018626725')
BEGIN
    SET @ShopIndex = ((100 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAR2026-060-4018626725', N'ANA M SANKAR', N'+1 555-300-1700', N'14 Black Oak, Irvine, CA, 92604.0', N'United States', @ShopId, @RoomId, N'Đang thêu', '2026-03-30 08:00:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4224, 1, N'https://www.etsy.com/ca/listing/4474915842/is-it-too-soon-to-ask-for-the-car-baby?transaction_id=5020775917', N'Romper Short - White - 3-6; SL: 1; Custom: no');
END

-- APR 2026 - đơn 001 - ViviEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-001-4016392590')
BEGIN
    SET @ShopIndex = ((101 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-001-4016392590', N'Allison Lopour', N'+1 555-301-1707', N'15391 Hanover Lane, Huntington Beach, CA, 92647', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-01 09:07:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4220, 1, N'https://www.etsy.com/ca/listing/4344235128/new-to-the-hive-baby-romper-embroidered?transaction_id=5011379112', N'Romper Short - Cream - 3-6; SL: 1; Custom: no');
END

-- APR 2026 - đơn 002 - ÁO_SHOP EmbroiWithCare
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-002-4011515568')
BEGIN
    SET @ShopIndex = ((102 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-002-4011515568', N'Leah Dainty', N'+1 555-302-1714', N'8623 Sugarberry creek, Brainerd, MN, 56401', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-02 10:14:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4164, 1, N'https://www.etsy.com/listing/4475409560/augusta-golf-icons-embroidered-baby?transaction_id=5014703489', N'Romper Longer - Dusty Pink - 0-3; SL: 1');
END

-- APR 2026 - đơn 003 - ÁO_SHOP PQT
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-003-4017002736')
BEGIN
    SET @ShopIndex = ((103 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-003-4017002736', N'Pagines her', N'+1 555-303-1721', N'90 Curtis Rd, Lawrenceville, GA, 30046-7310', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-01 11:21:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4165, 1, N'https://www.etsy.com/listing/4404016464/player-3-has-entered-the-game?transaction_id=5012174054', N'Romper Longer - Cream - 3-6; SL: 1');
END

-- APR 2026 - đơn 004 - Tramembroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-004-4019033891')
BEGIN
    SET @ShopIndex = ((104 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-004-4019033891', N'Cami Frahmann', N'+1 555-304-1728', N'7407 W Nicolet Ave, Glendale, AZ, 85303', N'United States', @ShopId, @RoomId, N'Chờ thêu', '2026-04-01 12:28:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4165, 1, N'https://www.etsy.com/ca/listing/4470615480/apparently-i-like-f1-baby-romper-formula?transaction_id=5021294609', N'Romper Longer - Cream - 3-6; SL: 1; Custom: no');
END

-- APR 2026 - đơn 005 - ÁO_SHOP_A.KHAI
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-005-4017960456')
BEGIN
    SET @ShopIndex = ((105 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-005-4017960456', N'Daisy North', N'+1 555-305-1735', N'8 Forester Row, Soberton, SO32, 3AS', N'United Kingdom', @ShopId, @RoomId, N'Hoàn thành', '2026-04-03 13:35:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4154, 1, N'https://www.etsy.com/listing/4481662420/embroidered-daddys-girl-baby-handmade?transaction_id=5013437628', N'Romper Longer - Cream - 0-3; SL: 1');
END

-- APR 2026 - đơn 006 - YourEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-006-4020667809')
BEGIN
    SET @ShopIndex = ((106 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-006-4020667809', N'Alice Heald', N'+1 555-306-1742', N'9 La Plage, Plat Douet Road, St Clement, Jersey, JE2 6ZZ', N'United Kingdom', @ShopId, @RoomId, N'Hoàn thành', '2026-04-02 14:42:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4176, 1, N'https://www.etsy.com/listing/4477977946/apparently-i-like-f1-baby-romper-funny?transaction_id=5013286660', N'Romper Longer - Cream - 6-12; SL: 1; Custom: no; Lưu ý: ĐẢO XA KO SHIP DC');
END

-- APR 2026 - đơn 007 - ProKsais
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-007-4023323668')
BEGIN
    SET @ShopIndex = ((107 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-007-4023323668', N'seuna catue', N'+1 555-307-1749', N'333 Sarah way, east stroudsburg, PA, 18301', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-08 15:49:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4267, 1, N'https://www.etsy.com/listing/4475350344/funny-firefighter-baby-bodysuit-mommy?transaction_id=5030940719', N'Bodysuit - Cream - 3-6; SL: 1; Custom: NO');
END

-- APR 2026 - đơn 008 - NDV96Store
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-008-4022407195')
BEGIN
    SET @ShopIndex = ((108 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-008-4022407195', N'Abigayle Mayat', N'+1 555-308-1756', N'907 Sundown Way, Erie, CO, 80516', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-04 16:56:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4231, 1, N'https://www.etsy.com/listing/4454899012/apparently-i-like-baseball-baby-romper?transaction_id=5015447162', N'Romper Short - Cream - 6-12; SL: 1; Custom: NO');
END

-- APR 2026 - đơn 009 - LittleHoopCo
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-009-4018469842')
BEGIN
    SET @ShopIndex = ((109 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-009-4018469842', N'Karla Martin', N'+1 555-309-1763', N'2209 Sunlit Ln, Raleigh, NC, 27604', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-02 17:03:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4264, 1, N'https://www.etsy.com/listing/4395093129/newest-hunting-buddy-baby-bodysuit-duck?transaction_id=5024263783', N'Bodysuit - Cream - 0-3; SL: 1; Custom: no');
END

-- APR 2026 - đơn 010 - ÁO_MottolaMind
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-010-4023974461')
BEGIN
    SET @ShopIndex = ((110 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-010-4023974461', N'Rachel Starr', N'+1 555-310-1770', N'203 W 90th St Ph H, Ph H, New York, NY, 10024-1246', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-06 08:10:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4220, 1, N'https://www.etsy.com/listing/4481664154/sous-chef-baby-romper-personalized?transaction_id=5017535022', N'Romper Short - Cream - 3-6; SL: 1; Custom: Sadie');
END

-- APR 2026 - đơn 011 - ViviEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-011-4018837925')
BEGIN
    SET @ShopIndex = ((111 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-011-4018837925', N'Hazel Goodwin', N'+1 555-311-1777', N'2538 Highway 571, Waterproof, LA, 71375', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-01 09:17:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4166, 1, N'https://www.etsy.com/ca/listing/4376399899/the-littlest-book-club-member-baby?transaction_id=5011059704', N'Romper Longer - Sage Green - 3-6; SL: 1; Custom: no');
END

-- APR 2026 - đơn 012 - ÁO_SHOP EmbroiWithCare
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-012-4018330318')
BEGIN
    SET @ShopIndex = ((112 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-012-4018330318', N'Tanner', N'+1 555-312-1784', N'12308 Sw 30th St, Yukon, OK, 73099', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-02 10:24:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4213, 1, N'https://www.etsy.com/listing/4475409560/augusta-golf-icons-embroidered-baby?transaction_id=5024066843', N'Romper Short - White - 0-3; SL: 1');
END

-- APR 2026 - đơn 013 - ÁO_SHOP PQT
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-013-4017304826')
BEGIN
    SET @ShopIndex = ((113 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-013-4017304826', N'Erin Gertken', N'+1 555-313-1791', N'27 Twinleaf Ct, Saint Peters, MO, 63376', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-01 11:31:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4154, 1, N'https://www.etsy.com/listing/4444685673/daddys-soccer-buddy-baby-romper-custom?transaction_id=5022661137', N'Romper Longer - Cream - 0-3; SL: 1');
END

-- APR 2026 - đơn 014 - Tramembroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-014-4018308598')
BEGIN
    SET @ShopIndex = ((114 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-014-4018308598', N'John Hayden Proctor', N'+1 555-314-1798', N'17 Red Cedar Cv, Little Rock, AR, 72212-3324', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-02 12:38:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4154, 1, N'https://www.etsy.com/ca/listing/4470615480/apparently-i-like-f1-baby-romper-formula?transaction_id=5024036863', N'Romper Longer - Cream - 0-3; SL: 1; Custom: no');
END

-- APR 2026 - đơn 015 - ÁO_SHOP_A.KHAI
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-015-4018235990')
BEGIN
    SET @ShopIndex = ((115 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-015-4018235990', N'Valbona Ismaili', N'+1 555-315-1805', N'2450 N Plum Grove Rd, Unit 307, SCHAUMBURG, IL, 60173-4860', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-03 13:45:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4154, 1, N'https://www.etsy.com/listing/4442483360/on-sundays-we-watch-with-daddy?transaction_id=5013790314', N'Romper Longer - Cream - 0-3; SL: 1');
END

-- APR 2026 - đơn 016 - YourEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-016-4018872530')
BEGIN
    SET @ShopIndex = ((116 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-016-4018872530', N'Melissa Panzarella', N'+1 555-316-1812', N'199 Schimwood Court, Getzville, NY, 14068', N'United States', @ShopId, @RoomId, N'Chưa có áo', '2026-04-03 14:52:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4221, 1, N'https://www.etsy.com/listing/4432961851/my-daddy-plays-in-the-dirt-baby-romper?transaction_id=5024840049', N'Romper Short - Sage Green - 3-6; SL: 1; Custom: NO');
END

-- APR 2026 - đơn 017 - ProKsais
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-017-4026964397')
BEGIN
    SET @ShopIndex = ((117 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-017-4026964397', N'Agnieszka Bartczak', N'+1 555-317-1819', N'2 Um Grousbuer, 5373 Schuttrange', N'Luxembourg', @ShopId, @RoomId, N'Chờ thêu', '2026-04-09 15:59:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4264, 1, N'https://www.etsy.com/listing/4445813613/future-pianist-embroidered-baby-bodysuit?transaction_id=5021525596', N'Bodysuit - Cream - 0-3; SL: 1; Custom: NO');
END

-- APR 2026 - đơn 018 - NDV96Store
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-018-4027470059')
BEGIN
    SET @ShopIndex = ((118 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-018-4027470059', N'Tara Fisher', N'+1 555-318-1826', N'24 Berkley Ct, Wayne, NJ, 07470-2426', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-09 16:06:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4224, 1, N'https://www.etsy.com/listing/4469990856/apparently-i-like-basketball-baby-romper?transaction_id=5032408273', N'Romper Short - White - 3-6; SL: 1; Custom: NO');
END

-- APR 2026 - đơn 019 - LittleHoopCo
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-019-4022460264')
BEGIN
    SET @ShopIndex = ((119 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-019-4022460264', N'Mrs. Mallori Wilbanks', N'+1 555-319-1833', N'3060 us hwy 280 Claxton, ga, Claxton, GA, 30417', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-07 17:13:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4154, 1, N'https://www.etsy.com/listing/4432405734/sweet-like-honey-embroidered-baby?transaction_id=5029714867', N'Romper Longer - Cream - 0-3; SL: 1; Custom: no');
END

-- APR 2026 - đơn 020 - ÁO_MottolaMind
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-020-4022289882')
BEGIN
    SET @ShopIndex = ((120 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-020-4022289882', N'Brittney Mork', N'+1 555-320-1840', N'4250 Jersey Covington Road, COVINGTON, GA, 30014', N'United States', @ShopId, @RoomId, N'Đang thêu', '2026-04-08 08:20:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4232, 1, N'https://www.etsy.com/listing/4481676592/thats-my-daddy-lineman-embroidered-baby?transaction_id=5029470559', N'Romper Short - Sage Green - 6-12; SL: 1');
END

-- APR 2026 - đơn 021 - ViviEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-021-4019282833')
BEGIN
    SET @ShopIndex = ((121 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-021-4019282833', N'Carlos Demelo', N'+1 555-321-1847', N'115 DOYLE DR, GUELPH, ON, N1G 5B4', N'Canada', @ShopId, @RoomId, N'Hoàn thành', '2026-04-01 09:27:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4232, 1, N'https://www.etsy.com/ca/listing/4392935796/box-box-for-fresh-diapers-embroidered?transaction_id=5011591898', N'Romper Short - Sage Green - 6-12; SL: 1; Custom: no');
END

-- APR 2026 - đơn 022 - ÁO_SHOP EmbroiWithCare
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-022-4020479861')
BEGIN
    SET @ShopIndex = ((122 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-022-4020479861', N'Natalie Harvey', N'+1 555-322-1854', N'11 Arrowhead Circle, Hickory Creek, TX, 75065', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-02 10:34:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4209, 1, N'https://www.etsy.com/listing/4471265235/personalized-masters-golf-embroidered?transaction_id=5023155175', N'Romper Short - Cream - 0-3; SL: 1; Custom: Huxton');
END

-- APR 2026 - đơn 023 - ÁO_SHOP PQT
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-023-4020570329')
BEGIN
    SET @ShopIndex = ((123 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-023-4020570329', N'Stephanie Gonzalez', N'+1 555-323-1861', N'9060 Spring Grove Drive, Baton Rouge, LA, 70809', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-01 11:41:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4269, 1, N'thiết kế riêng', N'Bodysuit - Light Pink - 3-6; SL: 1');
END

-- APR 2026 - đơn 024 - Tramembroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-024-4021760381')
BEGIN
    SET @ShopIndex = ((124 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-024-4021760381', N'Lucia Guzman', N'+1 555-324-1868', N'2229 W 18th Pl Bsmt, CHICAGO, IL, 60608-2506', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-03 12:48:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4154, 1, N'https://www.etsy.com/ca/listing/4476229576/daddys-future-trucking-buddy-baby-romper?transaction_id=5024863865', N'Romper Longer - Cream - 0-3; SL: 1; Custom: NO');
END

-- APR 2026 - đơn 025 - ÁO_SHOP_A.KHAI
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-025-4021867729')
BEGIN
    SET @ShopIndex = ((125 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-025-4021867729', N'Hollie Smith', N'+1 555-325-1875', N'201 Hartley St, Brockville, ON, K6V 3N4', N'Canada', @ShopId, @RoomId, N'Hoàn thành', '2026-04-04 13:55:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4269, 1, N'https://www.etsy.com/listing/4430837644/personalized-new-to-the-crew-baby?transaction_id=5024999045', N'Bodysuit - Light Pink - 3-6; SL: 1');
END

-- APR 2026 - đơn 026 - YourEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-026-4024463981')
BEGIN
    SET @ShopIndex = ((126 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-026-4024463981', N'Dawn Reavie', N'+1 555-326-1882', N'18 North Park Gdns, Belleville, ON, K8P 2M1', N'Canada', @ShopId, @RoomId, N'Hoàn thành', '2026-04-06 14:02:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4228, 1, N'https://www.etsy.com/listing/4437034638/funny-bowling-baby-romper-its-in-my-dna?transaction_id=5018278062', N'Romper Short - Salmon - 3-6; SL: 1; Custom: no');
END

-- APR 2026 - đơn 027 - ProKsais
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-027-4028668465')
BEGIN
    SET @ShopIndex = ((127 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-027-4028668465', N'Traci', N'+1 555-327-1889', N'2023 Froman Dr, Baden, PA, 15005-2718', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-10 15:09:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4268, 1, N'https://www.etsy.com/listing/4474939594/mommys-little-pierogi-baby-bodysuit-cute?transaction_id=5034017495', N'Bodysuit - Light Blue - 3-6; SL: 1; Custom: no');
END

-- APR 2026 - đơn 028 - NDV96Store
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-028-4025808242')
BEGIN
    SET @ShopIndex = ((128 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-028-4025808242', N'Jessica Naidu', N'+1 555-328-1896', N'1395 Adagietto Dr, Henderson, NV, 89052', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-11 16:16:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4235, 1, N'https://www.etsy.com/listing/4482243976/i-call-the-shots-baby-romper-funny?transaction_id=5034685549', N'Romper Short - White - 6-12; SL: 1; Custom: no');
END

-- APR 2026 - đơn 029 - LittleHoopCo
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-029-4027119376')
BEGIN
    SET @ShopIndex = ((129 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-029-4027119376', N'Julie Rombom', N'+1 555-329-1903', N'6 Goodwill Pl, EDISON, NJ, 08837', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-12 17:23:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4264, 1, N'https://www.etsy.com/listing/4427449114/kinda-a-big-dill-baby-bodysuit-funny?transaction_id=5025876044', N'Bodysuit - Cream - 0-3; SL: 1; Custom: no');
END

-- APR 2026 - đơn 030 - ÁO_MottolaMind
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-030-4025807061')
BEGIN
    SET @ShopIndex = ((130 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-030-4025807061', N'Kelsey Hrubes', N'+1 555-330-1910', N'110 Fairway Drive, Clear Lake, IA, 50428', N'United States', @ShopId, @RoomId, N'Chờ thêu', '2026-04-08 08:30:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4176, 1, N'https://www.etsy.com/listing/4472704816/little-chili-baby-romper-custom-name?transaction_id=5020022998', N'Romper Longer - Cream - 6-12; SL: 1');
END

-- APR 2026 - đơn 031 - ViviEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-031-4019608115')
BEGIN
    SET @ShopIndex = ((131 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-031-4019608115', N'Sam Wagnon', N'+1 555-331-1917', N'PO Box 2884, Breckenridge, CO, 80424-2884', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-01 09:37:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4227, 1, N'https://www.etsy.com/ca/listing/4376399899/the-littlest-book-club-member-baby?transaction_id=5022032877', N'Romper Short - Texas Orange - 3-6; SL: 1; Custom: no; Lưu ý: Gift message  Congratulations on the arrival of sweet baby Tripp! We are so excited to welcome the newest (and cutest) Book Club member!!  -- Book Club - Jess, Rhodri, Morgan, Matt');
END

-- APR 2026 - đơn 032 - ÁO_SHOP EmbroiWithCare
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-032-4020734447')
BEGIN
    SET @ShopIndex = ((132 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-032-4020734447', N'Debbi Walberg', N'+1 555-332-1924', N'12635 96th Street NE, Otsego, MN, 55330', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-02 10:44:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4174, 1, N'https://www.etsy.com/listing/4476314512/daddys-pit-crew-racing-flags-embroidered?transaction_id=5013377578', N'Romper Longer - Watermelon - 3-6; SL: 1');
END

-- APR 2026 - đơn 033 - ÁO_SHOP PQT
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-033-4021540076')
BEGIN
    SET @ShopIndex = ((133 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-033-4021540076', N'Macy Cohn', N'+1 555-333-1931', N'1534 W Caldwell St, Phoenix, AZ, 85041-7821', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-05 11:51:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4222, 1, N'https://www.etsy.com/in-en/listing/4473259477/personalized-space-baby-romper-name?transaction_id=5018310718', N'Romper Short - Caldet Blue - 3-6; SL: 1; Custom: oliver');
END

-- APR 2026 - đơn 034 - Tramembroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-034-0034')
BEGIN
    SET @ShopIndex = ((134 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-034-0034', N'Etsy Customer', N'+1 555-334-1938', N'Etsy order address APR2026-034-0034', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-04 12:58:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4166, 1, N'https://www.etsy.com/ca/listing/4447793500/its-in-my-dna-baby-romper-baseball-baby?transaction_id=5015439284', N'Romper Longer - Sage Green - 3-6; SL: 1');
END

-- APR 2026 - đơn 035 - ÁO_SHOP_A.KHAI
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-035-4022755633')
BEGIN
    SET @ShopIndex = ((135 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-035-4022755633', N'Judy Brooks', N'+1 555-335-1945', N'456 Ashland Ave, St Paul, MN, 55102', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-06 13:05:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4154, 1, N'https://www.etsy.com/listing/4469423916/personalized-tabby-cat-baby-custom-name?transaction_id=5015883146Time to eat fur, kid.', N'Romper Longer - Cream - 0-3; SL: 1; Custom: Time to eat fur, kid.');
END

-- APR 2026 - đơn 036 - YourEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-036-4025063614')
BEGIN
    SET @ShopIndex = ((136 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-036-4025063614', N'Emily Barnbrook', N'+1 555-336-1952', N'Clifford House, Stadium Way, Management Suite, Exeter, England, EX4 6AQ', N'United Kingdom', @ShopId, @RoomId, N'Hoàn thành', '2026-04-10 14:12:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4175, 1, N'https://www.etsy.com/listing/4477977946/apparently-i-like-f1-baby-romper-funny?transaction_id=5023178310', N'Romper Longer - Dusty Pink - 3-6; SL: 1; Custom: no; Lưu ý: 370 6004 28');
END

-- APR 2026 - đơn 037 - ProKsais
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-037-4027823428')
BEGIN
    SET @ShopIndex = ((137 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-037-4027823428', N'Rachel Mazur', N'+1 555-337-1959', N'4741 Thurlby Road, Mason, MI, 48854', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-13 15:19:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4154, 1, N'https://www.etsy.com/listing/4466846574/the-littlest-book-club-member-baby?transaction_id=5026793442', N'Romper Longer - Cream - 0-3; SL: 1; Custom: no');
END

-- APR 2026 - đơn 038 - NDV96Store
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-038-4029103651')
BEGIN
    SET @ShopIndex = ((138 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-038-4029103651', N'Jennifer Dhein', N'+1 555-338-1966', N'6252 155th Street NW, CLEARWATER, MN, 55320', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-11 16:26:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4175, 1, N'https://www.etsy.com/listing/4469480573/daddys-little-digger-embroidered-baby?transaction_id=5024051254', N'Romper Longer - Dusty Pink - 3-6; SL: 1; Custom: no');
END

-- APR 2026 - đơn 039 - LittleHoopCo
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-039-4029130430')
BEGIN
    SET @ShopIndex = ((139 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-039-4029130430', N'Peter Vogt', N'+1 555-339-1973', N'Grünaue 5, Mettmann, 40822', N'Germany', @ShopId, @RoomId, N'Hoàn thành', '2026-04-15 17:33:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4269, 1, N'https://www.etsy.com/listing/4396677612/daddys-future-lifting-buddy-bodysuit-new?transaction_id=5039488933', N'Bodysuit - Light Pink - 3-6; SL: 1; Custom: no');
END

-- APR 2026 - đơn 040 - ÁO_MottolaMind
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-040-4025932910')
BEGIN
    SET @ShopIndex = ((140 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-040-4025932910', N'Nicky Parsons', N'+1 555-340-1980', N'6837 LeilaniLn, Cypress, CA, 90630', N'United States', @ShopId, @RoomId, N'Đang thêu', '2026-04-13 08:40:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4230, 1, N'https://www.etsy.com/listing/4481664154/sous-chef-baby-romper-personalized?transaction_id=5024315364', N'Romper Short - Dusty Pink - 3-6; SL: 1');
END

-- APR 2026 - đơn 041 - ViviEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-041-4017196998')
BEGIN
    SET @ShopIndex = ((141 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-041-4017196998', N'Sandi Austin', N'+1 555-341-1987', N'1429 28ST SW, Calgary, AB, T3C 1L8', N'Canada', @ShopId, @RoomId, N'Hoàn thành', '2026-04-02 09:47:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4220, 2, N'https://www.etsy.com/ca/listing/4376399899/the-littlest-book-club-member-baby?transaction_id=5022514811', N'Romper Short - Cream - 3-6; SL: 2; Custom: no');
END

-- APR 2026 - đơn 042 - ÁO_SHOP EmbroiWithCare
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-042-4021404871')
BEGIN
    SET @ShopIndex = ((142 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-042-4021404871', N'Morgan Cartwright', N'+1 555-342-1994', N'30 Venue Cir, Apt 301, Lebanon, TN, 37090-1656', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-02 10:54:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4159, 1, N'https://www.etsy.com/listing/4321733094/embroidered-dump-truck-baby-romper?transaction_id=5014195404', N'Romper Longer - Coffee - 0-3; SL: 1');
END

-- APR 2026 - đơn 043 - ÁO_SHOP PQT
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-043-4023986011')
BEGIN
    SET @ShopIndex = ((143 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-043-4023986011', N'Tatiana Martinez', N'+1 555-343-2001', N'5 Mallard Lane, Bedminster, NJ, 07921', N'United States', @ShopId, @RoomId, N'Chờ thêu', '2026-04-05 11:01:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4165, 1, N'https://www.etsy.com/listing/4399230093/challah-at-your-boy-embroidered-baby?transaction_id=5027720615', N'Romper Longer - Cream - 3-6; SL: 1');
END

-- APR 2026 - đơn 044 - Tramembroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-044-4019455378')
BEGIN
    SET @ShopIndex = ((144 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-044-4019455378', N'Patricia Moreno', N'+1 555-344-2008', N'1542 condor ave, El Cajon, CA, 92019', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-04 12:08:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4161, 1, N'https://www.etsy.com/ca/listing/4449569507/mom-and-dads-game-changer-baby-romper?transaction_id=5015439286', N'Romper Longer - Texas Orange - 0-3; SL: 1; Custom: no');
END

-- APR 2026 - đơn 045 - ÁO_SHOP_A.KHAI
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-045-4022617418')
BEGIN
    SET @ShopIndex = ((145 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-045-4022617418', N'Makenna Mack', N'+1 555-345-2015', N'331 Ruth Street E, Saskatoon, SK, S7J 0L2', N'Canada', @ShopId, @RoomId, N'Chưa có áo', '2026-04-08 13:15:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4154, 1, N'https://www.etsy.com/listing/4453389627/new-to-the-cousin-crew-embroidered-baby?transaction_id=5019751994', N'Romper Longer - Cream - 0-3; SL: 1');
END

-- APR 2026 - đơn 046 - YourEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-046-4027909125')
BEGIN
    SET @ShopIndex = ((146 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-046-4027909125', N'Sharon Lin', N'+1 555-346-2022', N'1608 W Artesia Square, Unit c, Gardena, CA, 90248', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-10 14:22:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4242, 1, N'https://www.etsy.com/listing/4477977946/apparently-i-like-f1-baby-romper-funny?transaction_id=50226121600', N'Romper Short - Cream - 12-18; SL: 1; Custom: no');
END

-- APR 2026 - đơn 047 - ProKsais
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-047-4031047358')
BEGIN
    SET @ShopIndex = ((147 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-047-4031047358', N'Tamara Blau', N'+1 555-347-2029', N'9511 Portage Trail, White Lake, MI, 48386', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-17 15:29:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4165, 1, N'https://www.etsy.com/listing/4474936599/is-it-too-soon-to-ask-for-a-guitar-baby?transaction_id=5042143997', N'Romper Longer - Cream - 3-6; SL: 1; Custom: no');
END

-- APR 2026 - đơn 048 - NDV96Store
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-048-4029393103')
BEGIN
    SET @ShopIndex = ((148 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-048-4029393103', N'amy purce', N'+1 555-348-2036', N'8 Gerritt Street, OSWEGO, NY, 13126', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-11 16:36:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4186, 1, N'https://www.etsy.com/listing/4444103023/crawl-walk-snowmobile-baby-romper-funny?transaction_id=5024368100', N'Romper Longer - Dusty Pink - 6-12; SL: 1; Custom: no');
END

-- APR 2026 - đơn 049 - LittleHoopCo
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-049-4033388335')
BEGIN
    SET @ShopIndex = ((149 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-049-4033388335', N'Nicole Redmond', N'+1 555-349-2043', N'3341 Myrtle Grove Dr, BATON ROUGE, LA, 70810-1232', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-15 17:43:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4268, 1, N'https://www.etsy.com/listing/4418212637/born-to-snap-like-my-daddy-baby-bodysuit?transaction_id=5040017619', N'Bodysuit - Light Blue - 3-6; SL: 1; Custom: no');
END

-- APR 2026 - đơn 050 - ÁO_MottolaMind
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-050-4030850835')
BEGIN
    SET @ShopIndex = ((150 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-050-4030850835', N'Debby Gaspar', N'+1 555-350-2050', N'House next to park, 4 Dorset Street, Blacktown NSW 2148', N'Australia', @ShopId, @RoomId, N'Hoàn thành', '2026-04-13 08:50:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4154, 1, N'https://www.etsy.com/listing/4463219999/little-sprout-baby-romper-custom-name?transaction_id=5025980940', N'Romper Longer - Cream - 0-3; SL: 1');
END

-- APR 2026 - đơn 051 - ViviEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-051-4019854575')
BEGIN
    SET @ShopIndex = ((151 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-051-4019854575', N'Florian Boeni', N'+1 555-351-2057', N'Deuberrainweg 5, 8807 Freienbach', N'Switzerland', @ShopId, @RoomId, N'Hoàn thành', '2026-04-02 09:57:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4220, 1, N'https://www.etsy.com/ca/listing/4392936688/shhh-im-watching-motogp-with-daddy?transaction_id=5012274298', N'Romper Short - Cream - 3-6; SL: 1; Custom: no');
END

-- APR 2026 - đơn 052 - ÁO_SHOP EmbroiWithCare
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-052-4021629681')
BEGIN
    SET @ShopIndex = ((152 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-052-4021629681', N'Anastasia Bolshakov', N'+1 555-352-2064', N'10118 brush way, Iowa Colony, TX, 77583-1866', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-03 10:04:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4267, 1, N'https://www.etsy.com/listing/4376404086/embroidered-lil-nugget-baby-bodysuit?transaction_id=5014529724', N'Bodysuit - Cream - 3-6; SL: 1');
END

-- APR 2026 - đơn 053 - ÁO_SHOP PQT
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-053-4024800399')
BEGIN
    SET @ShopIndex = ((153 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-053-4024800399', N'Denise Dooks', N'+1 555-353-2071', N'10006 Highway 7, Head of Jeddore, NS, B0J 1P0', N'Canada', @ShopId, @RoomId, N'Hoàn thành', '2026-04-05 11:11:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4154, 1, N'https://www.etsy.com/in-en/listing/4474813381/daddys-fishing-buddy-baby-romper-custom?transaction_id=5018701850', N'Romper Longer - Cream - 0-3; SL: 1');
END

-- APR 2026 - đơn 054 - Tramembroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-054-4023651150')
BEGIN
    SET @ShopIndex = ((154 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-054-4023651150', N'Erica Sincich', N'+1 555-354-2078', N'174 Fuller Drive NE, WARREN, OH, 44484', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-08 12:18:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4169, 1, N'https://www.etsy.com/ca/listing/4474915842/is-it-too-soon-to-ask-for-the-car-baby?transaction_id=5031413447', N'Romper Longer - White - 3-6; SL: 1; Custom: no');
END

-- APR 2026 - đơn 055 - ÁO_SHOP_A.KHAI
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-055-4026757367')
BEGIN
    SET @ShopIndex = ((155 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-055-4026757367', N'Carol McCollem', N'+1 555-355-2085', N'105 Tyngsboro Rd, WESTFORD, MA, 01886', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-09 13:25:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4268, 1, N'https://www.etsy.com/listing/4435898453/personalized-soccer-ball-with-cap?transaction_id=5031457881', N'Bodysuit - Light Blue - 3-6; SL: 1; Custom: Colsen');
END

-- APR 2026 - đơn 056 - YourEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-056-4028357403')
BEGIN
    SET @ShopIndex = ((156 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-056-4028357403', N'Samantha Herbert', N'+1 555-356-2092', N'1303 Sage Lane, HARVARD, IL, 60033', N'United States', @ShopId, @RoomId, N'Chờ thêu', '2026-04-10 14:32:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4154, 1, N'https://www.etsy.com/listing/4436965790/daddys-future-riding-buddy-embroidered?transaction_id=5023195012', N'Romper Longer - Cream - 0-3; SL: 1; Custom: no');
END

-- APR 2026 - đơn 057 - ProKsais
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-057-4035340543')
BEGIN
    SET @ShopIndex = ((157 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-057-4035340543', N'Kriss Weber', N'+1 555-357-2099', N'3215 City Heights Rd, Ashland, WI, 54806', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-17 15:39:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4165, 1, N'https://www.etsy.com/listing/4444665236/born-to-stand-out-embroidered-baby?transaction_id=5042541631', N'Romper Longer - Cream - 3-6; SL: 1; Custom: no');
END

-- APR 2026 - đơn 058 - NDV96Store
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-058-4027010882')
BEGIN
    SET @ShopIndex = ((158 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-058-4027010882', N'Alexandra Scott', N'+1 555-358-2106', N'2553 Everwood Ct, Clarksville, TN, 37043', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-12 16:46:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4224, 1, N'https://www.etsy.com/listing/4461647435/daddys-little-co-pilot-baby-romper?transaction_id=5036488419', N'Romper Short - White - 3-6; SL: 1; Custom: no');
END

-- APR 2026 - đơn 059 - LittleHoopCo
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-059-4033768895')
BEGIN
    SET @ShopIndex = ((159 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-059-4033768895', N'Deneen Melos', N'+1 555-359-2113', N'4171 Hill Terrace Dr, Reading, PA, 19608', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-15 17:53:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4154, 1, N'https://www.etsy.com/listing/4441940535/special-delivery-embroidered-baby?transaction_id=5029462650', N'Romper Longer - Cream - 0-3; SL: 1; Custom: no');
END

-- APR 2026 - đơn 060 - ÁO_MottolaMind
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-060-4028983602')
BEGIN
    SET @ShopIndex = ((160 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-060-4028983602', N'Sabrina Jordan', N'+1 555-360-2120', N'909 Breakwater Drive, Annapolis, MD, 21403', N'United States', @ShopId, @RoomId, N'Đang thêu', '2026-04-15 08:00:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4244, 1, N'https://www.etsy.com/listing/4481649101/fitness-baby-romper-dumbbell?transaction_id=5039266033', N'Romper Short - Caldet Blue - 12-18; SL: 1; Custom: Brooks');
END

-- APR 2026 - đơn 061 - ViviEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-061-4020336859')
BEGIN
    SET @ShopIndex = ((161 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-061-4020336859', N'Ericka Fortson', N'+1 555-361-2127', N'10560 Wilshire Blvd, Apt 1405, Los Angeles, CA, 90024-7314', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-02 09:07:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4177, 1, N'https://www.etsy.com/ca/listing/4376399899/the-littlest-book-club-member-baby?transaction_id=5012860280', N'Romper Longer - Sage Green - 6-12; SL: 1; Custom: no');
END

-- APR 2026 - đơn 062 - ÁO_SHOP EmbroiWithCare
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-062-4021640475')
BEGIN
    SET @ShopIndex = ((162 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-062-4021640475', N'Elizabeth Mazzarella', N'+1 555-362-2134', N'25-18 34th St, Astoria, NY, 11103', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-03 10:14:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4222, 1, N'https://www.etsy.com/listing/4321796572/i-love-my-custom-name-embroidered-romper?transaction_id=5014545628', N'Romper Short - Caldet Blue - 3-6; SL: 1; Custom: Ama');
END

-- APR 2026 - đơn 063 - ÁO_SHOP PQT
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-063-0063')
BEGIN
    SET @ShopIndex = ((163 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-063-0063', N'------------------------------', N'+1 555-363-2141', N'------------------------------', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-05 11:21:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4211, 1, N'https://www.etsy.com/listing/4475400129/custom-pet-name-new-best-friend?transaction_id=5027720613', N'Romper Short - Caldet Blue - 0-3; SL: 1; Custom: Joey');
END

-- APR 2026 - đơn 064 - Tramembroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-064-4027482269')
BEGIN
    SET @ShopIndex = ((164 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-064-4027482269', N'Daniel Rivers', N'+1 555-364-2148', N'8 Concord Avenue, Derry, NH, 03038', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-09 12:28:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4209, 1, N'https://www.etsy.com/ca/listing/4470615480/apparently-i-like-f1-baby-romper-formula?transaction_id=5022118458', N'Romper Short - Cream - 0-3; SL: 1; Custom: NO');
END

-- APR 2026 - đơn 065 - ÁO_SHOP_A.KHAI
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-065-4024338119')
BEGIN
    SET @ShopIndex = ((165 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-065-4024338119', N'Pamela Belcher', N'+1 555-365-2155', N'92 Gooney Otter Hollow, Covel, WV, 24719', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-10 13:35:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4265, 1, N'https://www.etsy.com/listing/4481677271/personalized-basketball-baby-bodysuit?transaction_id=5018132062', N'Bodysuit - Light Blue - 0-3; SL: 1; Custom: Elias');
END

-- APR 2026 - đơn 066 - YourEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-066-4026498392')
BEGIN
    SET @ShopIndex = ((166 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-066-4026498392', N'Morgan Reece', N'+1 555-366-2162', N'662 Bouldercrest Dr SW, Marietta, GA, 30064-3310', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-12 14:42:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4257, 1, N'https://www.etsy.com/listing/4436476647/golf-baby-romper-embroidered-golf-theme?transaction_id=5035725219', N'Romper Short - White - 18-24; SL: 1; Custom: no');
END

-- APR 2026 - đơn 067 - ProKsais
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-067-0067')
BEGIN
    SET @ShopIndex = ((167 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-067-0067', N'Etsy Customer', N'+1 555-367-2169', N'Etsy order address APR2026-067-0067', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-18 15:49:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4264, 1, N'https://www.etsy.com/listing/4485620709/nap-now-jam-later-baby-bodysuit-funny?transaction_id=5044388543', N'Bodysuit - Cream - 0-3; SL: 1; Custom: no');
END

-- APR 2026 - đơn 068 - NDV96Store
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-068-4031686349')
BEGIN
    SET @ShopIndex = ((168 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-068-4031686349', N'Jennifer McCluskey', N'+1 555-368-2176', N'18 Emerald Circle, Cabot, AR, 72023', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-04-13 16:56:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4213, 1, N'https://www.etsy.com/listing/4485588168/new-to-the-club-baby-romper-golf-baby?transaction_id=5037845985', N'Romper Short - White - 0-3; SL: 1; Custom: no');
END

-- APR 2026 - đơn 069 - LittleHoopCo
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-069-4034622333')
BEGIN
    SET @ShopIndex = ((169 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-069-4034622333', N'Miss Kaci McLaughlin', N'+1 555-369-2183', N'95 S Underwood Dr, Covington, GA, 30016-1975', N'United States', @ShopId, @RoomId, N'Chờ thêu', '2026-04-16 17:03:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4154, 1, N'https://www.etsy.com/listing/4395094410/do-not-kiss-me-if-im-nacho-baby?transaction_id=5041607177', N'Romper Longer - Cream - 0-3; SL: 1; Custom: Personalization: Kaci Rose');
END

-- APR 2026 - đơn 070 - ÁO_MottolaMind
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'APR2026-070-4039339531')
BEGIN
    SET @ShopIndex = ((170 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'APR2026-070-4039339531', N'Marwa almadani', N'+1 555-370-2190', N'RAJB7671, 7671 Al Amin Mohammed Al Durair,, 3145, AlNarjis District, Riyadh 1134', N'Saudi Arabia', @ShopId, @RoomId, N'Hoàn thành', '2026-04-22 08:10:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4160, 1, N'https://www.etsy.com/listing/4472718936/power-lifting-baby-romper-custom-name?transaction_id=5035703080', N'Romper Longer - Forest Green - 0-3; SL: 1');
END

-- MAY 2026 - đơn 001 - ÁO_SHOP EmbroiWithCare
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-001-0001')
BEGIN
    SET @ShopIndex = ((171 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-001-0001', N'Etsy Customer', N'+1 555-371-2197', N'Etsy order address MAY2026-001-0001', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-01 09:07:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4222, 1, N'https://www.etsy.com/listing/4371146171/personalized-baby-romper-embroidered?transaction_id=5047164888', N'Romper Short - Caldet Blue - 3-6; SL: 1; Custom: George Initial Name: G');
END

-- MAY 2026 - đơn 002 - ViviEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-002-0002')
BEGIN
    SET @ShopIndex = ((172 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-002-0002', N'Etsy Customer', N'+1 555-372-2204', N'Etsy order address MAY2026-002-0002', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-01 10:14:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4225, 1, N'https://www.etsy.com/ca/listing/4372357398/personalized-hunting-baby-romper-custom?transaction_id=5060968109', N'Romper Short - Coffee - 3-6; SL: 1; Custom: Rusty');
END

-- MAY 2026 - đơn 003 - ÁO_SHOP PQT
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-003-4050991935')
BEGIN
    SET @ShopIndex = ((173 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-003-4050991935', N'Marcelo Trallero Salgado', N'+1 555-373-2211', N'465 Franklin Rd, Sandy Springs, GA, 30342-2712', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-02 11:21:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4165, 1, N'https://www.etsy.com/listing/4485710996/masters-2026-augusta-national-golf-club?transaction_id=5062649795', N'Romper Longer - Cream - 3-6; SL: 1');
END

-- MAY 2026 - đơn 004 - ProKsais
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-004-4045951266')
BEGIN
    SET @ShopIndex = ((174 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-004-4045951266', N'Deanne Ruiz', N'+1 555-374-2218', N'634 Laurel Dr, Dyer, IN, 46311', N'United States', @ShopId, @RoomId, N'Chưa có áo', '2026-05-02 12:28:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4267, 1, N'https://www.etsy.com/listing/4474939594/mommys-little-pierogi-baby-bodysuit-cute?transaction_id=5063070439', N'Bodysuit - Cream - 3-6; SL: 1; Custom: no');
END

-- MAY 2026 - đơn 005 - NDV96Store
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-005-4047918846')
BEGIN
    SET @ShopIndex = ((175 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-005-4047918846', N'marion clignet', N'+1 555-375-2225', N'14 Avenue Armand Sylvestre, 65400 Argeles-Gazost, France', N'+33 6 51 96 88 34', @ShopId, @RoomId, N'Hoàn thành', '2026-05-01 13:35:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4219, 1, N'https://www.etsy.com/listing/4490501214/little-cycling-club-baby-romper-bicycle?transaction_id=5065323629', N'Romper Short - Dusty Pink - 0-3; SL: 1; Custom: no');
END

-- MAY 2026 - đơn 006 - ÁO_SHOP_A.KHAI
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-006-4042470122')
BEGIN
    SET @ShopIndex = ((176 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-006-4042470122', N'Jennifer Curley', N'+1 555-376-2232', N'38 Moulton Rd, Hampton, NH, 03842-2154', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-02 14:42:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4265, 1, N'https://www.etsy.com/listing/4430837644/personalized-new-to-the-crew-baby?transaction_id=5045980734', N'Bodysuit - Light Blue - 0-3; SL: 1');
END

-- MAY 2026 - đơn 007 - LittleHoopCo
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-007-0007')
BEGIN
    SET @ShopIndex = ((177 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-007-0007', N'Etsy Customer', N'+1 555-377-2239', N'Etsy order address MAY2026-007-0007', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-03 15:49:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4266, 1, N'https://www.etsy.com/listing/4491435314/just-plane-cute-baby-bodysuit-airplane?transaction_id=5064335675', N'Bodysuit - Light Pink - 0-3; SL: 1; Custom: no');
END

-- MAY 2026 - đơn 008 - Tramembroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-008-4045080886')
BEGIN
    SET @ShopIndex = ((178 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-008-4045080886', N'Annie Clark', N'+1 555-378-2246', N'15205 E 21st Ave, Spokane Valley, WA, 99037', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-01 16:56:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4165, 1, N'https://www.etsy.com/ca/listing/4483717191/new-to-the-squad-embroidered-baby-romper?transaction_id=5049302690', N'Romper Longer - Cream - 3-6; SL: 1; Custom: no');
END

-- MAY 2026 - đơn 009 - YourEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-009-4056377034')
BEGIN
    SET @ShopIndex = ((179 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-009-4056377034', N'Chloe Reading', N'+1 555-379-2253', N'41 Lumeah Drive, Cranbourne West VIC 3977', N'Australia', @ShopId, @RoomId, N'Hoàn thành', '2026-05-13 17:03:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4169, 1, N'https://www.etsy.com/listing/4477977946/apparently-i-like-f1-baby-romper-funny?transaction_id=5076305981', N'Romper Longer - White - 3-6; SL: 1; Custom: no');
END

-- MAY 2026 - đơn 010 - ÁO_MottolaMind
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-010-4049997283')
BEGIN
    SET @ShopIndex = ((180 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-010-4049997283', N'Victoria Gaba', N'+1 555-380-2260', N'8716 Nalley Road, Villa Rica, GA, 30180-3034', N'United States', @ShopId, @RoomId, N'Đang thêu', '2026-05-03 08:10:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4246, 1, N'https://www.etsy.com/listing/4473244004/personalized-baby-romper-embroidered?transaction_id=5061381751', N'Romper Short - White - 12-18; SL: 1; Custom: GIO');
END

-- MAY 2026 - đơn 011 - ÁO_SHOP EmbroiWithCare
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-011-4041931584')
BEGIN
    SET @ShopIndex = ((181 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-011-4041931584', N'Stacy Hayes', N'+1 555-381-2267', N'PO Box 703, Douglass, KS, 67039', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-01 09:17:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4264, 1, N'https://www.etsy.com/listing/4376404086/embroidered-lil-nugget-baby-bodysuit?transaction_id=5058063317', N'Bodysuit - Cream - 0-3; SL: 1');
END

-- MAY 2026 - đơn 012 - ViviEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-012-0012')
BEGIN
    SET @ShopIndex = ((182 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-012-0012', N'Etsy Customer', N'+1 555-382-2274', N'Etsy order address MAY2026-012-0012', N'United States', @ShopId, @RoomId, N'Chờ thêu', '2026-05-01 10:24:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4154, 1, N'https://www.etsy.com/ca/listing/4346126210/daddys-future-lifting-buddy-romper-baby?transaction_id=5064583587', N'Romper Longer - Cream - 0-3; SL: 1; Custom: Mommy''s Future Lifting Buddy');
END

-- MAY 2026 - đơn 013 - ÁO_SHOP PQT
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-013-4051402767')
BEGIN
    SET @ShopIndex = ((183 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-013-4051402767', N'AAron Smolyar', N'+1 555-383-2281', N'41 River Ter, APT 3106, New York, NY, 10282-1125', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-02 11:31:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4167, 1, N'https://www.etsy.com/listing/4480598946/tennis-racket-ball-name-embroidered-baby?transaction_id=5050510506', N'Romper Longer - Caldet Blue - 3-6; SL: 1; Custom: Aaron');
END

-- MAY 2026 - đơn 014 - ProKsais
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-014-0014')
BEGIN
    SET @ShopIndex = ((184 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-014-0014', N'Etsy Customer', N'+1 555-384-2288', N'Etsy order address MAY2026-014-0014', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-03 12:38:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4165, 1, N'https://www.etsy.com/listing/4449064143/future-tractor-driver-embroidered-baby?transaction_id=5049132944', N'Romper Longer - Cream - 3-6; SL: 1; Custom: no');
END

-- MAY 2026 - đơn 015 - NDV96Store
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-015-4050919816')
BEGIN
    SET @ShopIndex = ((185 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-015-4050919816', N'crystal smith', N'+1 555-385-2295', N'7891 Breezewood Dr, Iola, TX, 77861-3936', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-07 13:45:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4241, 1, N'https://www.etsy.com/listing/4475336563/my-daddy-is-faster-than-your-daddy-baby?transaction_id=5056677068', N'Romper Short - Dusty Pink - 6-12; SL: 1; Custom: no');
END

-- MAY 2026 - đơn 016 - ÁO_SHOP_A.KHAI
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-016-4043380844')
BEGIN
    SET @ShopIndex = ((186 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-016-4043380844', N'Chelsea Place', N'+1 555-386-2302', N'11 Quaker Ln, Northbridge, MA, 01534-1242', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-02 14:52:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4154, 1, N'https://www.etsy.com/listing/4491489849/handpicked-for-earth-by-my-mimi-in?transaction_id=5059802481', N'Romper Longer - Cream - 0-3; SL: 1');
END

-- MAY 2026 - đơn 017 - LittleHoopCo
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-017-4046961770')
BEGIN
    SET @ShopIndex = ((187 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-017-4046961770', N'Dina Wallin', N'+1 555-387-2309', N'725 Florida St, Unit 13, San Francisco, CA, 94110', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-03 15:59:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4268, 1, N'https://www.etsy.com/listing/4488346062/honk-honk-baby-bodysuit-funny-duck-car?transaction_id=5064239197', N'Bodysuit - Light Blue - 3-6; SL: 1; Custom: no');
END

-- MAY 2026 - đơn 018 - Tramembroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-018-0018')
BEGIN
    SET @ShopIndex = ((188 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-018-0018', N'Etsy Customer', N'+1 555-388-2316', N'Etsy order address MAY2026-018-0018', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-03 16:06:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4178, 1, N'https://www.etsy.com/ca/listing/4470615480/apparently-i-like-f1-baby-romper-formula?transaction_id=5064410381', N'Romper Longer - Caldet Blue - 6-12; SL: 1; Custom: no');
END

-- MAY 2026 - đơn 019 - YourEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-019-0019')
BEGIN
    SET @ShopIndex = ((189 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-019-0019', N'Etsy Customer', N'+1 555-389-2323', N'Etsy order address MAY2026-019-0019', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-14 17:13:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4169, 1, N'https://www.etsy.com/listing/4430529702/cool-as-a-penguin-embroidered-baby?transaction_id=5065975440', N'Romper Longer - White - 3-6; SL: 1; Custom: no');
END

-- MAY 2026 - đơn 020 - ÁO_MottolaMind
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-020-4048092420')
BEGIN
    SET @ShopIndex = ((190 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-020-4048092420', N'Zora Miel Curry Taylor', N'+1 555-390-2330', N'710 Windcrest Rd, Durham, NC, 27713-9753', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-05 08:20:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4225, 1, N'https://www.etsy.com/listing/4473246782/new-baby-romper-dog-paw-embroidered?transaction_id=5053101910', N'Romper Short - Coffee - 3-6; SL: 1');
END

-- MAY 2026 - đơn 021 - ÁO_SHOP EmbroiWithCare
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-021-4041967358')
BEGIN
    SET @ShopIndex = ((191 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-021-4041967358', N'Marilyne Ziegler', N'+1 555-391-2337', N'6914 10th line, Thornton, ON, L0L 2N0', N'Canada', @ShopId, @RoomId, N'Hoàn thành', '2026-05-01 09:27:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4234, 1, N'https://www.etsy.com/listing/4490562378/apparently-i-like-jets-embroidered-baby?transaction_id=5058107821', N'Romper Short - Mauve Taupe - 6-12; SL: 1');
END

-- MAY 2026 - đơn 022 - ViviEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-022-4044247016')
BEGIN
    SET @ShopIndex = ((192 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-022-4044247016', N'Casey Walker', N'+1 555-392-2344', N'1160 Lawson Cove Cir, Virginia Beach, VA, 23455', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-01 10:34:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4210, 1, N'https://www.etsy.com/ca/listing/4471139539/daddys-future-hunting-buddy-baby-romper?transaction_id=5060968111', N'Romper Short - Sage Green - 0-3; SL: 1; Custom: no');
END

-- MAY 2026 - đơn 023 - ÁO_SHOP PQT
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-023-0023')
BEGIN
    SET @ShopIndex = ((193 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-023-0023', N'--------------------------', N'+1 555-393-2351', N'--------------------------', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-03 11:41:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4211, 1, N'https://www.etsy.com/listing/4485708190/daddys-little-caddy-embroidered-baby?transaction_id=5064110813', N'Romper Short - Caldet Blue - 0-3; SL: 1');
END

-- MAY 2026 - đơn 024 - ProKsais
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-024-4052395921')
BEGIN
    SET @ShopIndex = ((194 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-024-4052395921', N'Rebecca Crose', N'+1 555-394-2358', N'11 Christmas Tree Lane, Woodbridge, CT, 06525', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-03 12:48:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4267, 1, N'https://www.etsy.com/listing/4486243785/on-call-for-snacks-baby-bodysuit-funny?transaction_id=5064426787', N'Bodysuit - Cream - 3-6; SL: 1; Custom: no');
END

-- MAY 2026 - đơn 025 - NDV96Store
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-025-4053954434')
BEGIN
    SET @ShopIndex = ((195 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-025-4053954434', N'Katarina Dragojlovic', N'+1 555-395-2365', N'Schwenckestrasse 2, Hamburg, 20257', N'Germany', @ShopId, @RoomId, N'Chờ thêu', '2026-05-10 13:55:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4171, 1, N'https://www.etsy.com/listing/4482244700/apparently-i-like-tennis-baby-romper?transaction_id=5073031741', N'Romper Longer - Forest Green - 3-6; SL: 1; Custom: no');
END

-- MAY 2026 - đơn 026 - ÁO_SHOP_A.KHAI
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-026-4045609444')
BEGIN
    SET @ShopIndex = ((196 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-026-4045609444', N'Nina Känsäkangas-Erkkilä', N'+1 555-396-2372', N'Varpuskuja 5, 67800 Kokkola', N'Finland', @ShopId, @RoomId, N'Hoàn thành', '2026-05-04 14:02:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4269, 1, N'https://www.etsy.com/listing/4429019252/personalized-badminton-baby-bodysuit?transaction_id=5062650773', N'Bodysuit - Light Pink - 3-6; SL: 1');
END

-- MAY 2026 - đơn 027 - LittleHoopCo
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-027-4052323099')
BEGIN
    SET @ShopIndex = ((197 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-027-4052323099', N'Tona Quinton', N'+1 555-397-2379', N'204 Tattlers Trail, Irmo, SC, 29063', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-03 15:09:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4265, 1, N'https://www.etsy.com/listing/4491435314/just-plane-cute-baby-bodysuit-airplane?transaction_id=5064335675', N'Bodysuit - Light Blue - 0-3; SL: 1; Custom: no');
END

-- MAY 2026 - đơn 028 - Tramembroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-028-4052382741')
BEGIN
    SET @ShopIndex = ((198 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-028-4052382741', N'Katelyn Barnett', N'+1 555-398-2386', N'210 Trails End, GREENVILLE, SC, 29607', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-03 16:16:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4244, 1, N'https://www.etsy.com/ca/listing/4470615480/apparently-i-like-f1-baby-romper-formula?transaction_id=5064410381', N'Romper Short - Caldet Blue - 12-18; SL: 1; Custom: no');
END

-- MAY 2026 - đơn 029 - YourEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-029-4058057524')
BEGIN
    SET @ShopIndex = ((199 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-029-4058057524', N'Grace Cheung', N'+1 555-399-2393', N'22 Moore Place, San Francisco, CA, 94109', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-14 17:23:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4154, 1, N'https://www.etsy.com/listing/4430532176/little-tiger-embroidered-baby-romper?transaction_id=5065975442', N'Romper Longer - Cream - 0-3; SL: 1; Custom: no');
END

-- MAY 2026 - đơn 030 - ÁO_MottolaMind
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-030-4057986483')
BEGIN
    SET @ShopIndex = ((200 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-030-4057986483', N'GORKA FUENTES LEJARZA', N'+1 555-400-2400', N'Ostindiefararen 31, 185.0, SE-417 65 Göteborg', N'Sweden', @ShopId, @RoomId, N'Đang thêu', '2026-05-12 08:30:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4211, 1, N'https://www.etsy.com/listing/4473237491/embroidered-ocean-wave-baby-romper?transaction_id=5071531853', N'Romper Short - Caldet Blue - 0-3; SL: 1');
END

-- MAY 2026 - đơn 031 - ÁO_SHOP EmbroiWithCare
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-031-4042360300')
BEGIN
    SET @ShopIndex = ((201 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-031-4042360300', N'Tia Oaster', N'+1 555-401-2407', N'93 Ambler Rd, ASHEVILLE, NC, 28805', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-01 09:37:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4166, 1, N'https://www.etsy.com/listing/4321796572/i-love-my-custom-name-embroidered-romper?transaction_id=5058591347', N'Romper Longer - Sage Green - 3-6; SL: 1; Custom: Gigi');
END

-- MAY 2026 - đơn 032 - ViviEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-032-4044743206')
BEGIN
    SET @ShopIndex = ((202 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-032-4044743206', N'Dana Rasmus', N'+1 555-402-2414', N'107 Stannard Avenue, BRANFORD, CT, 06405', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-01 10:44:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4210, 1, N'https://www.etsy.com/ca/listing/4369781522/crawl-walk-putt-baby-romper-funny-golf?transaction_id=5061565359', N'Romper Short - Sage Green - 0-3; SL: 1; Custom: no');
END

-- MAY 2026 - đơn 033 - ÁO_SHOP PQT
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-033-4046314642')
BEGIN
    SET @ShopIndex = ((203 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-033-4046314642', N'Luis Torras Barthe', N'+1 555-403-2421', N'Carrer de Josep Bertrand 3 5º 1, Piso 5 Puerta 1, 08021 Barcelona Barcelona', N'Spain', @ShopId, @RoomId, N'Chưa có áo', '2026-05-03 11:51:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4165, 1, N'https://www.etsy.com/listing/4485710996/masters-2026-augusta-national-golf-club?transaction_id=5063497185', N'Romper Longer - Cream - 3-6; SL: 1; Lưu ý: IM3720000224  Viết thiếp, chụp ảnh "Enhorabuena pareja. De parte de vuestros amigos Luis Torras, Jorge Mañnas y Gonzalo Acha"');
END

-- MAY 2026 - đơn 034 - ProKsais
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-034-4053282535')
BEGIN
    SET @ShopIndex = ((204 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-034-4053282535', N'Zora Miel Curry Taylor', N'+1 555-404-2428', N'710 Windcrest Rd, Durham, NC, 27713-9753', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-04 12:58:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4165, 1, N'https://www.etsy.com/listing/4485629164/the-littlest-dog-lovers-club-member-baby?transaction_id=5065549629', N'Romper Longer - Cream - 3-6; SL: 1; Custom: no');
END

-- MAY 2026 - đơn 035 - NDV96Store
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-035-4059302363')
BEGIN
    SET @ShopIndex = ((205 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-035-4059302363', N'Nadine Tweedie', N'+1 555-405-2435', N'38 Gleason Street, McDowall QLD 4053', N'Australia', @ShopId, @RoomId, N'Hoàn thành', '2026-05-10 13:05:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4232, 1, N'https://www.etsy.com/listing/4489486323/daddys-running-buddy-baby-romper-funny?transaction_id=5060714182', N'Romper Short - Sage Green - 6-12; SL: 1; Custom: no');
END

-- MAY 2026 - đơn 036 - ÁO_SHOP_A.KHAI
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-036-4049481078')
BEGIN
    SET @ShopIndex = ((206 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-036-4049481078', N'Stacie Piatt Vaughn', N'+1 555-406-2442', N'1961 North 400 East Road, Gilman, IL, 60938', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-06 14:12:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4269, 1, N'https://www.etsy.com/listing/4469526782/thats-my-daddy-embroidered-baby-lineman?transaction_id=5067342233', N'Bodysuit - Light Pink - 3-6; SL: 1');
END

-- MAY 2026 - đơn 037 - LittleHoopCo
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-037-4048295126')
BEGIN
    SET @ShopIndex = ((207 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-037-4048295126', N'melissa lecy', N'+1 555-407-2449', N'12885 Foliage Ave., Apple Valley, MN, 55124', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-04 15:19:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4267, 1, N'https://www.etsy.com/listing/4488345640/future-triathlete-baby-bodysuit-swim?transaction_id=5053355894', N'Bodysuit - Cream - 3-6; SL: 1; Custom: no');
END

-- MAY 2026 - đơn 038 - Tramembroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-038-4048116904')
BEGIN
    SET @ShopIndex = ((208 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-038-4048116904', N'Meagan McDavid', N'+1 555-408-2456', N'1445 Kirkway Rd, Bloomfield Hills, MI, 48302', N'United States', @ShopId, @RoomId, N'Chờ thêu', '2026-05-04 16:26:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4177, 1, N'https://www.etsy.com/ca/listing/4471171185/crawl-walk-golf-baby-romper-100-cotton?transaction_id=5053132478', N'Romper Longer - Sage Green - 6-12; SL: 1; Custom: no');
END

-- MAY 2026 - đơn 039 - YourEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-039-4066394829')
BEGIN
    SET @ShopIndex = ((209 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-039-4066394829', N'Breanna Henney', N'+1 555-409-2463', N'2767 W 1650 N, Clinton, UT, 84015-7907', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-17 17:33:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4155, 1, N'https://www.etsy.com/listing/4442025933/embroidered-baby-romper-player-3-has?transaction_id=5069406242', N'Romper Longer - Sage Green - 0-3; SL: 1; Custom: no');
END

-- MAY 2026 - đơn 040 - ÁO_MottolaMind
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-040-4057234406')
BEGIN
    SET @ShopIndex = ((210 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-040-4057234406', N'Patricia Hammon', N'+1 555-410-2470', N'PO Box 2656, Colorado City, AZ, 86021', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-14 08:40:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4220, 1, N'https://www.etsy.com/listing/4481671705/relax-my-daddy-is-a-firefighter?transaction_id=5064884800', N'Romper Short - Cream - 3-6; SL: 1');
END

-- MAY 2026 - đơn 041 - ÁO_SHOP EmbroiWithCare
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-041-4042461910')
BEGIN
    SET @ShopIndex = ((211 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-041-4042461910', N'Taylor Laverdiere', N'+1 555-411-2477', N'2525 Tracy Lane, Gilberstville, PA, 19525', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-01 09:47:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4242, 1, N'https://www.etsy.com/listing/4473845389/golf-player-outfit-embroidered-baby?transaction_id=5058713571', N'Romper Short - Cream - 12-18; SL: 1; Custom: Grayson; Lưu ý: Tóc đổi thành màu nâu, CHỌN MÀU NÂU ĐẬM NHẤT');
END

-- MAY 2026 - đơn 042 - ViviEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-042-4049891797')
BEGIN
    SET @ShopIndex = ((212 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-042-4049891797', N'Mathias Wagner', N'+1 555-412-2484', N'Ludwig Hupfeld Straße 26, Autowerk Leipzig GmbH, Leipzig, 04178', N'Germany', @ShopId, @RoomId, N'Hoàn thành', '2026-05-01 10:54:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4211, 1, N'https://www.etsy.com/ca/listing/4392932100/born-to-ride-with-my-daddy-embroidered?transaction_id=5048538918', N'Romper Short - Caldet Blue - 0-3; SL: 1; Custom: no');
END

-- MAY 2026 - đơn 043 - ÁO_SHOP PQT
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-043-4048654475')
BEGIN
    SET @ShopIndex = ((213 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-043-4048654475', N'Caitlin Lamm', N'+1 555-413-2491', N'5821 White Way Cir, Metter, GA, 30439-5692', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-03 11:01:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4211, 1, N'https://www.etsy.com/in-en/listing/4477320181/personalized-mouse-name-baby-romper?transaction_id=5046991818', N'Romper Short - Caldet Blue - 0-3; SL: 1; Custom: Mouse');
END

-- MAY 2026 - đơn 044 - ProKsais
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-044-4050480212')
BEGIN
    SET @ShopIndex = ((214 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-044-4050480212', N'Pablo', N'+1 555-414-2498', N'601 N Second St, P O Box 611, Hico, TX, 76457-6215', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-06 12:08:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4267, 1, N'https://www.etsy.com/listing/4470004184/little-lamb-baby-bodysuit-cute-lamb-baby?transaction_id=5056121936', N'Bodysuit - Cream - 3-6; SL: 1; Custom: no');
END

-- MAY 2026 - đơn 045 - NDV96Store
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-045-4055310088')
BEGIN
    SET @ShopIndex = ((215 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-045-4055310088', N'Roger Noon', N'+1 555-415-2505', N'251 A Avenue Ln, Coronado, CA, 92118-1919', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-11 13:15:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4247, 1, N'https://www.etsy.com/listing/4444093935/its-in-my-dna-baseball-baby-romper?transaction_id=5074856931', N'Romper Short - Coffee - 12-18; SL: 1; Custom: no');
END

-- MAY 2026 - đơn 046 - ÁO_SHOP_A.KHAI
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-046-4049518894')
BEGIN
    SET @ShopIndex = ((216 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-046-4049518894', N'Sherlyn Visani', N'+1 555-416-2512', N'2140 S Flora Ct, Lakewood, CO, 80228', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-06 14:22:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4268, 1, N'https://www.etsy.com/listing/4477382165/holy-blockamole-bodysuit-embroidered?transaction_id=5067388177', N'Bodysuit - Light Blue - 3-6; SL: 1');
END

-- MAY 2026 - đơn 047 - LittleHoopCo
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-047-4053585929')
BEGIN
    SET @ShopIndex = ((217 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-047-4053585929', N'Tracey Williams', N'+1 555-417-2519', N'14 Lake St, BROMLEY, KY, 41016', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-04 15:29:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4268, 1, N'https://www.etsy.com/listing/4395078760/new-to-the-hunting-crew-baby-bodysuit?transaction_id=5053462096', N'Bodysuit - Light Blue - 3-6; SL: 1; Custom: no');
END

-- MAY 2026 - đơn 048 - Tramembroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-048-4054430205')
BEGIN
    SET @ShopIndex = ((218 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-048-4054430205', N'DAVID DOUCETTE', N'+1 555-418-2526', N'7700 Old Linton Hall Rd, Gainesville, VA, 20155-1727', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-05 16:36:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4220, 1, N'https://www.etsy.com/ca/listing/4470615480/apparently-i-like-f1-baby-romper-formula?transaction_id=5067011323', N'Romper Short - Cream - 3-6; SL: 1; Custom: no');
END

-- MAY 2026 - đơn 049 - YourEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-049-4060747262')
BEGIN
    SET @ShopIndex = ((219 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-049-4060747262', N'Mahaila Bland', N'+1 555-419-2533', N'7412 S 85th Street, La Vista, NE, 68128', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-18 17:43:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4211, 1, N'https://www.etsy.com/listing/4499062845/custom-name-embroidered-romper-baby-gift?transaction_id=5082502647', N'Romper Short - Caldet Blue - 0-3; SL: 1; Custom: Going home to meet my new best friends; Lưu ý: Trình bày 2 con chó và 3 con mèo theo bố cục như này nhé https://i.etsystatic.com/icm/519a30/882956803/icm_fullxfull.882956803_32oaiio1244kwwccgcwo.png?version=0 https://i.etsystatic.com/icm/541d82/883212317/icm_fullxfull.883212317_k7q5w3pyes0cs0gkskg8.jpg?version=0 https://i.etsystatic.com/icm/753933/878800220/icm_fullxfull.878800220_lg6zki5ovpwsswkgwscg.jpg?version=0 https://i.etsystatic.com/icm/d27');
END

-- MAY 2026 - đơn 050 - ÁO_MottolaMind
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-050-4062309193')
BEGIN
    SET @ShopIndex = ((220 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-050-4062309193', N'Andrea Cooper', N'+1 555-420-2540', N'2004 W. Knights Griffin Rd, Plant City, FL, 33565', N'United States', @ShopId, @RoomId, N'Đang thêu', '2026-05-14 08:50:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4232, 1, N'https://www.etsy.com/listing/4473230310/future-metalhead-baby-romper-custom-name?transaction_id=5077162729', N'Romper Short - Sage Green - 6-12; SL: 1');
END

-- MAY 2026 - đơn 051 - ÁO_SHOP EmbroiWithCare
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-051-4043399366')
BEGIN
    SET @ShopIndex = ((221 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-051-4043399366', N'Jennifer Byrd', N'+1 555-421-2547', N'13411 Beckenham Dr, Little Rock, AR, 72212', N'United States', @ShopId, @RoomId, N'Chờ thêu', '2026-05-01 09:57:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4233, 1, N'https://www.etsy.com/listing/4371146171/personalized-baby-romper-embroidered?transaction_id=5059825789', N'Romper Short - Caldet Blue - 6-12; SL: 1; Custom: Custom Name: George Initial Name: G');
END

-- MAY 2026 - đơn 052 - ViviEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-052-4050130161')
BEGIN
    SET @ShopIndex = ((222 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-052-4050130161', N'Jamie Byrne', N'+1 555-422-2554', N'2735 Mountain Brook Dr, Apt C306, Longmont, CO, 80503-7096', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-01 10:04:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4154, 1, N'https://www.etsy.com/ca/listing/4336903235/personalized-tennis-baby-romper?transaction_id=5048860854', N'Romper Longer - Cream - 0-3; SL: 1; Custom: no');
END

-- MAY 2026 - đơn 053 - ÁO_SHOP PQT
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-053-4052144227')
BEGIN
    SET @ShopIndex = ((223 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-053-4052144227', N'Jaime Schumacher', N'+1 555-423-2561', N'W3205 Kortney Ln, SEYMOUR, WI, 54165', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-03 11:11:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4210, 1, N'https://www.etsy.com/listing/4485708190/daddys-little-caddy-embroidered-baby?transaction_id=5064110813', N'Romper Short - Sage Green - 0-3; SL: 1');
END

-- MAY 2026 - đơn 054 - ProKsais
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-054-4055692169')
BEGIN
    SET @ShopIndex = ((224 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-054-4055692169', N'James Goddard', N'+1 555-424-2568', N'12109 Cygnet Blvd, Grande Prairie AB T8X 1N3, Canada', N'+1 250-859-5813', @ShopId, @RoomId, N'Hoàn thành', '2026-05-06 12:18:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4165, 1, N'https://www.etsy.com/listing/4482268262/is-it-too-soon-to-ask-for-a-pony-baby?transaction_id=5056108504', N'Romper Longer - Cream - 3-6; SL: 1; Custom: no');
END

-- MAY 2026 - đơn 055 - NDV96Store
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-055-4056473518')
BEGIN
    SET @ShopIndex = ((225 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-055-4056473518', N'Kim Richardson', N'+1 555-425-2575', N'2135 Ross Rd, Social Circle, GA, 30025', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-13 13:25:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4160, 1, N'https://www.etsy.com/listing/4489486323/daddys-running-buddy-baby-romper-funny?transaction_id=5076450535', N'Romper Longer - Forest Green - 0-3; SL: 1; Custom: no');
END

-- MAY 2026 - đơn 056 - ÁO_SHOP_A.KHAI
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-056-4055357605')
BEGIN
    SET @ShopIndex = ((226 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-056-4055357605', N'Martha Wilson', N'+1 555-426-2582', N'137 Endeavour Ave, East River Point, NS, B0J 1T0', N'Canada', @ShopId, @RoomId, N'Hoàn thành', '2026-05-07 14:32:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4269, 1, N'https://www.etsy.com/listing/4430837644/personalized-new-to-the-crew-baby?transaction_id=5055711684', N'Bodysuit - Light Pink - 3-6; SL: 1');
END

-- MAY 2026 - đơn 057 - LittleHoopCo
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-057-4048974432')
BEGIN
    SET @ShopIndex = ((227 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-057-4048974432', N'Margaret Fraumeni', N'+1 555-427-2589', N'1557 Dave Pl, Yuba City, CA, 95993-8939', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-06 15:39:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4267, 1, N'https://www.etsy.com/listing/4493907972/book-lover-baby-bodysuit-shh-im-reading?transaction_id=5054223622', N'Bodysuit - Cream - 3-6; SL: 1; Custom: no');
END

-- MAY 2026 - đơn 058 - Tramembroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-058-4055352425')
BEGIN
    SET @ShopIndex = ((228 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-058-4055352425', N'Cody Dupuis', N'+1 555-428-2596', N'24972 Fairtime Cir, Laguna Niguel, CA, 92677', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-06 16:46:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4209, 1, N'https://www.etsy.com/ca/listing/4470615480/apparently-i-like-f1-baby-romper-formula?transaction_id=5068179367', N'Romper Short - Cream - 0-3; SL: 1; Custom: no');
END

-- MAY 2026 - đơn 059 - YourEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-059-4062133774')
BEGIN
    SET @ShopIndex = ((229 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-059-4062133774', N'Katherine Barger', N'+1 555-429-2603', N'1100 Trinket Ct, Des Peres, MO, 63131', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-19 17:53:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4166, 1, N'https://www.etsy.com/listing/4499062845/custom-name-embroidered-romper-baby-gift?transaction_id=5084428685', N'Romper Longer - Sage Green - 3-6; SL: 1; Custom: Weller; Lưu ý: https://i.etsystatic.com/icm/432374/880461554/icm_fullxfull.880461554_mmqich2a6v44cokkkgk4.png?version=0');
END

-- MAY 2026 - đơn 060 - ÁO_MottolaMind
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-060-4062747487')
BEGIN
    SET @ShopIndex = ((230 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-060-4062747487', N'Lorraine Smith', N'+1 555-430-2610', N'2 Canal Cottage, Old Warwick Road, Solihull, Warwickshire, B94 6BA', N'United Kingdom', @ShopId, @RoomId, N'Hoàn thành', '2026-05-15 08:00:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4213, 1, N'https://www.etsy.com/listing/4472700822/sun-baby-romper-little-ray-of-sunshine?transaction_id=5077774187', N'Romper Short - White - 0-3; SL: 1');
END

-- MAY 2026 - đơn 061 - ÁO_SHOP EmbroiWithCare
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-061-4043408398')
BEGIN
    SET @ShopIndex = ((231 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-061-4043408398', N'Gabi Duncan', N'+1 555-431-2617', N'1800 Terrace Ave, 14.0, Knoxville, TN, 37916', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-01 09:07:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4214, 1, N'https://www.etsy.com/listing/4321796572/i-love-my-custom-name-embroidered-romper?transaction_id=5059837131', N'Romper Short - Coffee - 0-3; SL: 1; Custom: Aunt JoJo');
END

-- MAY 2026 - đơn 062 - ViviEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-062-4050289451')
BEGIN
    SET @ShopIndex = ((232 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-062-4050289451', N'Cory Seeger', N'+1 555-432-2624', N'28 Land Grant, Irvine, CA, 92618-8858', N'United States', @ShopId, @RoomId, N'Chưa có áo', '2026-05-01 10:14:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4209, 1, N'https://www.etsy.com/ca/listing/4376389783/player-2-baby-romper-gamer-baby-outfit?transaction_id=5061755139', N'Romper Short - Cream - 0-3; SL: 1; Custom: Player 2');
END

-- MAY 2026 - đơn 063 - ÁO_SHOP PQT
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-063-4052505031')
BEGIN
    SET @ShopIndex = ((233 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-063-4052505031', N'Janice Johnson', N'+1 555-433-2631', N'2000 Michelle Dr, Brookfield, WI, 53045-5038', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-03 11:21:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4265, 1, N'https://www.etsy.com/listing/4481741792/little-bean-coffee-lover-embroidered?transaction_id=5064565183', N'Bodysuit - Light Blue - 0-3; SL: 1');
END

-- MAY 2026 - đơn 064 - ProKsais
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-064-4054618604')
BEGIN
    SET @ShopIndex = ((234 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-064-4054618604', N'Mateo Ferner', N'+1 555-434-2638', N'2661 Sand Hollow Dr, Lebanon, IN, 46052-0035', N'United States', @ShopId, @RoomId, N'Chờ thêu', '2026-05-11 12:28:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4268, 1, N'https://www.etsy.com/listing/4475352752/reading-with-mommy-baby-bodysuit-cute?transaction_id=5061492840', N'Bodysuit - Light Blue - 3-6; SL: 1; Custom: no');
END

-- MAY 2026 - đơn 065 - NDV96Store
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-065-4062455673')
BEGIN
    SET @ShopIndex = ((235 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-065-4062455673', N'Vicki Meachum', N'+1 555-435-2645', N'1442 Sixth st, Berkeley, CA, 94702', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-13 13:35:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4166, 1, N'https://www.etsy.com/listing/4461643687/daddys-future-lifting-buddy-embroidered?transaction_id=5077348049', N'Romper Longer - Sage Green - 3-6; SL: 1; Custom: no');
END

-- MAY 2026 - đơn 066 - ÁO_SHOP_A.KHAI
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-066-4050605424')
BEGIN
    SET @ShopIndex = ((236 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-066-4050605424', N'TJ Auva''a - Level 4 AA Insurance Ltd', N'+1 555-436-2652', N'46 Sale Street, Auckland Central, Auckland 1010', N'New Zealand', @ShopId, @RoomId, N'Hoàn thành', '2026-05-08 14:42:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4269, 1, N'https://www.etsy.com/listing/4429012108/future-lifting-buddy-embroidered-baby?transaction_id=5068794219', N'Bodysuit - Light Pink - 3-6; SL: 1');
END

-- MAY 2026 - đơn 067 - LittleHoopCo
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-067-4054724456')
BEGIN
    SET @ShopIndex = ((237 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-067-4054724456', N'Taryn Rosa', N'+1 555-437-2659', N'4003 Welty Ln, Mount Juliet, TN, 37122-2294', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-11 15:49:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4269, 1, N'https://www.etsy.com/listing/4396672648/pickle-baby-embroidered-baby-bodysuit?transaction_id=5061625354', N'Bodysuit - Light Pink - 3-6; SL: 1; Custom: no');
END

-- MAY 2026 - đơn 068 - Tramembroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-068-4062513167')
BEGIN
    SET @ShopIndex = ((238 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-068-4062513167', N'Lee Esgro', N'+1 555-438-2666', N'4275 Wind Tree Cove, Bartlett, TN, 38135', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-13 16:56:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4222, 1, N'https://www.etsy.com/ca/listing/4470615480/apparently-i-like-f1-baby-romper-formula?transaction_id=5064754984', N'Romper Short - Caldet Blue - 3-6; SL: 1; Custom: NO');
END

-- MAY 2026 - đơn 069 - YourEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-069-0675400671')
BEGIN
    SET @ShopIndex = ((239 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-069-0675400671', N'Aimee Arsenian', N'+1 555-439-2673', N'50 Gage Girls Road, BEDFORD, NH, 03110', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-19 17:03:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4166, 2, N'https://www.etsy.com/listing/4432961851/my-daddy-plays-in-the-dirt-baby-romper?transaction_id=5070887878', N'Romper Longer - Sage Green - 3-6; SL: 2; Custom: NO');
END

-- MAY 2026 - đơn 070 - ÁO_MottolaMind
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-070-4058124296')
BEGIN
    SET @ShopIndex = ((240 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-070-4058124296', N'Amy Bradley', N'+1 555-440-2680', N'4103 Flower Garden Drive, Arlington, TX, 76016', N'United States', @ShopId, @RoomId, N'Đang thêu', '2026-05-18 08:10:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4220, 1, N'https://www.etsy.com/listing/4473244004/personalized-baby-romper-embroidered?transaction_id=5078858179', N'Romper Short - Cream - 3-6; SL: 1; Custom: bridger');
END

-- MAY 2026 - đơn 071 - ÁO_SHOP EmbroiWithCare
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-071-4042578408')
BEGIN
    SET @ShopIndex = ((241 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-071-4042578408', N'Peyton Knochel', N'+1 555-441-2687', N'515 Stone Creek Way, Apt F, Cincinnati, OH, 45255-4815', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-02 09:17:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4164, 1, N'https://www.etsy.com/listing/4321796572/i-love-my-custom-name-embroidered-romper?transaction_id=5058848139', N'Romper Longer - Dusty Pink - 0-3; SL: 1; Custom: Nan');
END

-- MAY 2026 - đơn 072 - ViviEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-072-4050306097')
BEGIN
    SET @ShopIndex = ((242 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-072-4050306097', N'Kylee Willis', N'+1 555-442-2694', N'754 Bingham avenue, OZARK, AL, 36360', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-01 10:24:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4154, 1, N'https://www.etsy.com/ca/listing/4475325519/daddys-future-fishing-buddy-baby?transaction_id=5049095320', N'Romper Longer - Cream - 0-3; SL: 1; Custom: no');
END

-- MAY 2026 - đơn 073 - ÁO_SHOP PQT
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-073-4052729287')
BEGIN
    SET @ShopIndex = ((243 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-073-4052729287', N'Elizabeth Ratcliffe', N'+1 555-443-2701', N'Tilehurst Rectory, Routh Lane, Tilehurst, Reading, England, RG30 4JY', N'United Kingdom', @ShopId, @RoomId, N'Hoàn thành', '2026-05-03 11:31:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4265, 1, N'https://www.etsy.com/listing/4404016464/player-3-has-entered-the-game?transaction_id=5052362998', N'Bodysuit - Light Blue - 0-3; SL: 1; Lưu ý: 370 6004 28');
END

-- MAY 2026 - đơn 074 - ProKsais
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-074-4054990030')
BEGIN
    SET @ShopIndex = ((244 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-074-4054990030', N'Susan Hannon', N'+1 555-444-2708', N'1968 Juliet Avenue, Saint Paul, MN, 55105', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-11 12:38:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4266, 1, N'https://www.etsy.com/listing/4500801384/little-peanut-baby-bodysuit-embroidered?transaction_id=5074448259', N'Bodysuit - Light Pink - 0-3; SL: 1; Custom: no');
END

-- MAY 2026 - đơn 075 - NDV96Store
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-075-4062997159')
BEGIN
    SET @ShopIndex = ((245 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-075-4062997159', N'Kate Rose', N'+1 555-445-2715', N'22 Bootham Terrace, YORK, England, YO30 7DH', N'United Kingdom', @ShopId, @RoomId, N'Hoàn thành', '2026-05-14 13:45:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4160, 1, N'https://www.etsy.com/listing/4492117324/red-hot-silly-peppers-baby-romper-funny', N'Romper Longer - Forest Green - 0-3; SL: 1; Custom: no');
END

-- MAY 2026 - đơn 076 - ÁO_SHOP_A.KHAI
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-076-4055286892')
BEGIN
    SET @ShopIndex = ((246 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-076-4055286892', N'Vonnie Bradbury', N'+1 555-446-2722', N'6785 Yelliwstone trl, Huntley, MT, 59037', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-12 14:52:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4265, 1, N'https://www.etsy.com/listing/4430824034/funny-apparently-i-like-golf-baby?transaction_id=5062332512', N'Bodysuit - Light Blue - 0-3; SL: 1');
END

-- MAY 2026 - đơn 077 - LittleHoopCo
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-077-4056146666')
BEGIN
    SET @ShopIndex = ((247 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-077-4056146666', N'Karen Clemmenson', N'+1 555-447-2729', N'508 Hancock Dr, MULLICA HILL, NJ, 08062', N'United States', @ShopId, @RoomId, N'Chờ thêu', '2026-05-12 15:59:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4268, 1, N'https://www.etsy.com/listing/4471165394/i-love-my-gigi-embroidered-baby-bodysuit?transaction_id=5075960083', N'Bodysuit - Light Blue - 3-6; SL: 1; Custom: NO');
END

-- MAY 2026 - đơn 078 - Tramembroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-078-4065626391')
BEGIN
    SET @ShopIndex = ((248 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-078-4065626391', N'Cassie Frengopoulos', N'+1 555-448-2736', N'163 Edgehill Dr, D3 Barrie ON L4N 1L9, Canada', N'17058178558.0', @ShopId, @RoomId, N'Hoàn thành', '2026-05-13 16:06:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4167, 1, N'https://www.etsy.com/ca/listing/4470615480/apparently-i-like-f1-baby-romper-formula?transaction_id=5068477926', N'Romper Longer - Caldet Blue - 3-6; SL: 1; Custom: no');
END

-- MAY 2026 - đơn 079 - YourEmbroidery
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-079-4071836055')
BEGIN
    SET @ShopIndex = ((249 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-079-4071836055', N'Kaitlin Hunt', N'+1 555-449-2743', N'10345 Magnolia Lane, Parkville, MO, 64152', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-24 17:13:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4215, 1, N'https://www.etsy.com/listing/4442025933/embroidered-baby-romper-player-3-has?ls=r&ref=related-2&content_source=85be4b993b6f0396b102a41914204abd%253ALT2926146063257692f2dd099b1216fa34cf8a56be&logging_key=85be4b993b6f0396b102a41914204abd%3ALT2926146063257692f2dd099b1216fa34cf8a56be', N'Romper Short - Forest Green - 0-3; SL: 1; Custom: no');
END

-- MAY 2026 - đơn 080 - ÁO_MottolaMind
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderCode = N'MAY2026-080-4063210124')
BEGIN
    SET @ShopIndex = ((250 - 1) % @ShopCount) + 1;
    SELECT @ShopId = ShopId, @RoomId = RoomId FROM #ShopPool WHERE rn = @ShopIndex;
    INSERT INTO dbo.Orders
    (OrderCode, CustomerName, PhoneNumber, Address, Country, ShopId, RoomId, Status, CreateAt)
    VALUES
    (N'MAY2026-080-4063210124', N'Terri Alphin Smith', N'+1 555-450-2750', N'621 Richlands Loop Rd, Richlands, NC, 28574', N'United States', @ShopId, @RoomId, N'Hoàn thành', '2026-05-21 08:20:00');
    SET @OrderId = SCOPE_IDENTITY();
    INSERT INTO dbo.OrderDetails
    (OrderId, ProductVariantId, Quantity, ProductLink, Note)
    VALUES (@OrderId, 4162, 1, N'https://www.etsy.com/listing/4463219999/little-sprout-baby-romper-custom-name?transaction_id=5072742920', N'Romper Longer - Salmon - 0-3; SL: 1');
END

DROP TABLE #ShopPool;
COMMIT TRANSACTION;

-- Kiểm tra số lượng sau khi chạy:
SELECT MONTH(CreateAt) AS Thang, COUNT(*) AS SoDon
FROM dbo.Orders
WHERE CreateAt >= '2026-01-01' AND CreateAt < '2026-06-01'
GROUP BY MONTH(CreateAt)
ORDER BY Thang;

SELECT OrderCode, COUNT(*) AS SoLanTrung
FROM dbo.Orders
GROUP BY OrderCode
HAVING COUNT(*) > 1;