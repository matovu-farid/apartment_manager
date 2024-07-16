# frozen_string_literal: true

json.array! @rent_sessions, partial: 'rent_sessions/rent_session', as: :rent_session
