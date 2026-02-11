require 'faker'

JoinTableDoctorSpecialty.destroy_all
Appointment.destroy_all
Doctor.destroy_all
Patient.destroy_all
Specialty.destroy_all
City.destroy_all

puts "Base de données nettoyée !"

# --- CRÉATION DES VILLES ---
10.times do
  City.create!(
    name: Faker::Address.city
  )
end
puts "10 villes créées."

# --- CRÉATION DES SPÉCIALITÉS ---
specialties_list = ["Généraliste", "Cardiologue", "Dentiste", "Ophtalmologue", "Psychiatre", "Neurologue", "Pédiatre"]
specialties_list.each do |name|
  Specialty.create!(name: name)
end
puts "Spécialités créées."

# --- CRÉATION DES DOCTEURS ---
20.times do
  doctor = Doctor.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    zip_code: Faker::Address.zip_code,
    city: City.all.sample # On prend une ville au hasard
  )
  # On lui donne 1 ou 2 spécialités au hasard
  rand(1..2).times do
    JoinTableDoctorSpecialty.create!(
      doctor: doctor,
      specialty: Specialty.all.sample
    )
  end
end
puts "20 docteurs créés."

# --- CRÉATION DES PATIENTS ---
50.times do
  Patient.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    city: City.all.sample
  )
end
puts "50 patients créés."

# --- CRÉATION DES RENDEZ-VOUS ---
100.times do
  # On choisit un docteur au hasard
  doc = Doctor.all.sample
  Appointment.create!(
    date: Faker::Time.between(from: DateTime.now, to: DateTime.now + 30),
    doctor: doc,
    patient: Patient.all.sample,
    city: doc.city # Le RDV est dans la ville du docteur
  )
end
puts "100 rendez-vous créés. Seed terminé !"