

# SCARA Robot: Modeling, Simulation and Control (MATLAB + Arduino)

*Bridging simulation and real-world robotics through kinematics, visualization, and embedded control.*

![Animation](media/animation.gif)

---

## 📌 Overview
This project presents the development of a SCARA (Selective Compliance Assembly Robot Arm) robot, including its modeling, simulation, animation, and physical implementation using MATLAB and Arduino.

The system integrates forward and inverse kinematics, real-time visualization, and control of servo motors, enabling both simulation and real-world robotic motion.

---

## 🎯 Objectives
- Develop a function to draw a SCARA robot using joint variables  
- Implement forward and inverse kinematics  
- Animate robot motion using joint trajectories  
- Control a physical SCARA robot using Arduino  
- Validate simulation results with real hardware  

---

## ⚙️ Robot Configuration
The SCARA robot consists of:
- Two revolute joints → θ₁, θ₂  
- One prismatic joint → d₃  

These variables define the position of the end-effector in 3D space.

---

## 🧠 Kinematics

### 📍 Forward Kinematics
The forward kinematics computes the position of the end-effector:

x = L1 cos(θ₁) + L2 cos(θ₁ + θ₂)  
y = L1 sin(θ₁) + L2 sin(θ₁ + θ₂)  
z = -d₃  

---

### 🔄 Inverse Kinematics
The inverse kinematics determines the joint variables from a desired position:

- θ₂ is obtained using the cosine law  
- θ₁ is calculated using geometric relations  
- d₃ is obtained directly from the z-axis  

---

## 🖥️ MATLAB Implementation

### 🔹 Robot Visualization
A custom function was implemented to draw the SCARA robot using line segments:

- P0 → Base  
- P1 → First joint  
- P2 → Second joint  
- P3 → End-effector  

The robot is visualized in 3D using `plot3`.

---

### 🔹 Motion Animation
The robot motion is generated dynamically by varying joint values over time:

```matlab
for t = 0:0.1:2*pi
    theta1 = rad2deg(t);
    theta2 = rad2deg(sin(t));
    d3 = 0.5 + 0.2*sin(t);
end
