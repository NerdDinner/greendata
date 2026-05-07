from datetime import datetime, time

# обработка заказа
def process_order(order_sum):

    status = ""
    assigned_to = None
    can_edit_until = None
    
    # проверка минимальной суммы
    if order_sum < 1000:
        return "Возврат в корзину: Минимальная сумма заказа для оформления — 1 000 руб."
    
    # обработка интервала 1000 - 5000
    if 1000 <= order_sum < 5000:
        status = "IN_DELIVERY"
        assigned_to = "COURIER"
        can_edit_until = datetime.combine(datetime.now().date(), time(23, 59, 59))
        return f"Заказ оформлен автоматически. Статус: {status}. Редактирование до: {can_edit_until}. Исполнитель: {assigned_to}."

    # обработка интервала от 5000
    elif order_sum >= 5000:
        status = "AWAITING_CONFIRMATION"
        assigned_to = "MANAGER"
        return f"Заказ требует подтверждения менеджером. Статус: {status}. Исполнитель: {assigned_to}."

# TODO: подтверждение менеджером
def confirm_order_by_manager(order_id):
    confirmed_at = datetime.now()
    can_edit_until = datetime.combine(confirmed_at.date(), time(23, 59, 59))
    return f"Заказ {order_id} подтвержден. Редактирование разрешено до {can_edit_until}"

# main
test_sums = [800, 2500, 6000]
for s in test_sums:
    result = process_order(s)
    print(f"Сумма: {s}. Результат: {result}")
