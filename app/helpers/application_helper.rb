module ApplicationHelper
  def active?(status)
    status ? 'success' : 'danger'
  end

  def swal_type(type)
    case type
    when 'success', 'notice' then 'success'
    when 'alert' then 'warning'
    when 'danger', 'error', 'denied' then 'error'
    when 'question' then 'question'
    else 'info'
    end
  end

  def enterprises
    @enterprises ||= current_user.roles.includes(:enterprise).map(&:enterprise)
  end

  def abbreviation(word)
    word.split.map(&:first).join.upcase
  end

  def formatted(document_number)
    case document_number.size
    when 11
      CPF.new(document_number).formatted
    when 14
      CNPJ.new(document_number).formatted
    end
  end

  def not_persisted_action?
    ['new', 'create'].include?(action_name)
  end

  def users_collection
    users = []
    query = User.includes(:person).where(person: { enterprise: current_user.current_enterprise })

    query.each do |user|
      users << ["#{user.person.name} | #{user.email}", user.id]
    end

    users.sort
  end

  def transactions_collection
    transactions = []
    query = Transaction.where(owner: current_user)

    query.each do |transaction|
      transactions << ["#{transaction.transaction_type.description} ##{transaction.identifier} | #{number_to_currency(transaction.value)}", transaction.id]
    end

    transactions.sort
  end

  def current_role_kind
    current_user.roles.find_by(enterprise: current_user.current_enterprise)&.kind
  end

  def can_access_admin?
    return unless current_user.present? && current_user.current_enterprise.present?

    User::Role::ADMIN_KINDS.include?(current_role_kind)
  end

  def tradelock_time(skin)
    return if skin.expiration_date < Date.current

    days_left = (skin.expiration_date.to_date - Date.current).to_i

    case days_left
    when 0
      'Hoje'
    when 1
      "#{days_left} dia"
    else
      "#{days_left} dias"
    end
  end

  def status_class(status)
    status_map = {
      pending: 'primary',
      finished: 'success'
    }

    status_map[status.to_sym] || ''
  end

  def transaction_types_collection
    transaction_types = []
    query = Transaction::Type.where(enterprise: current_user.current_enterprise)

    query.each do |transaction_type|
      transaction_types << ["#{transaction_type.description}", transaction_type.id]
    end

    transaction_types.sort
  end
end
