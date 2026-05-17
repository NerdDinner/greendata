#Написать алгоритмы по пункту 3 


from datetime import datetime, time

# проверка суммы заказа
def check_order(order_sum):
    
    # проверка минимальной суммы
    if order_sum < 1000:
        return "Заказ можно оформить при сумме более 1 000 руб."
    
    # обработка интервала 1000 - 5000
    if 1000 <= order_sum < 5000:
        status = "IN_DELIVERY"
        assigned_to = "COURIER"
        can_edit_until = datetime.combine(datetime.now().date(), time(23, 59, 59))
        return f"Заказ оформлен автоматически. Статус: {status}. Редактирование до: {can_edit_until}. Исполнитель: {assigned_to}."

    # от 5000
    elif order_sum >= 5000:
        status = "AWAITING_CONFIRMATION"
        assigned_to = "MANAGER"
        return f"Заказ требует подтверждения менеджером. Статус: {status}. Исполнитель: {assigned_to}."

#основной блок программы
test_sums = [800, 2500, 6000]
for s in test_sums:
    result = check_order(s)
    print(f"Сумма: {s}. {result}")
