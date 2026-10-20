///===
/// extcore/chem_desc_geometric

pub(all) struct ChemdescgeometricPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_desc_geometric_make_point(x : Double, y : Double) -> ChemdescgeometricPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_desc_geometric_make_point3(x : Double, y : Double, z : Double) -> ChemdescgeometricPoint {
  { x, y, z, label: 0 }
}

pub fn ChemdescgeometricPoint::x(self : ChemdescgeometricPoint) -> Double { self.x }

pub fn ChemdescgeometricPoint::y(self : ChemdescgeometricPoint) -> Double { self.y }

pub fn ChemdescgeometricPoint::z(self : ChemdescgeometricPoint) -> Double { self.z }

pub fn ChemdescgeometricPoint::label(self : ChemdescgeometricPoint) -> Int { self.label }

pub fn ChemdescgeometricPoint::dist(self : ChemdescgeometricPoint, other : ChemdescgeometricPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemdescgeometricPoint::add(self : ChemdescgeometricPoint, other : ChemdescgeometricPoint) -> ChemdescgeometricPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemdescgeometricPoint::sub(self : ChemdescgeometricPoint, other : ChemdescgeometricPoint) -> ChemdescgeometricPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemdescgeometricPoint::scale(self : ChemdescgeometricPoint, s : Double) -> ChemdescgeometricPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemdescgeometricPoint::dot(self : ChemdescgeometricPoint, other : ChemdescgeometricPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemdescgeometricPoint::cross(self : ChemdescgeometricPoint, other : ChemdescgeometricPoint) -> ChemdescgeometricPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemdescgeometricPoint::norm(self : ChemdescgeometricPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemdescgeometricPoint::normalize(self : ChemdescgeometricPoint) -> ChemdescgeometricPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemdescgeometricPoint::negate(self : ChemdescgeometricPoint) -> ChemdescgeometricPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemdescgeometricPoint::mid(self : ChemdescgeometricPoint, other : ChemdescgeometricPoint) -> ChemdescgeometricPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemdescgeometricPoint::lerp(self : ChemdescgeometricPoint, other : ChemdescgeometricPoint, t : Double) -> ChemdescgeometricPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemdescgeometricPoint::to_string(self : ChemdescgeometricPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemdescgeometricSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_desc_geometric_make_series(vals : Array[Double], name : String) -> ChemdescgeometricSeries {
  { vals, name, meta: 0 }
}

pub fn ChemdescgeometricSeries::len(self : ChemdescgeometricSeries) -> Int { self.vals.length() }

pub fn ChemdescgeometricSeries::sum(self : ChemdescgeometricSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemdescgeometricSeries::mean(self : ChemdescgeometricSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemdescgeometricSeries::min(self : ChemdescgeometricSeries) -> Double { @_common.min(self.vals) }

pub fn ChemdescgeometricSeries::max(self : ChemdescgeometricSeries) -> Double { @_common.max(self.vals) }

pub fn ChemdescgeometricSeries::range(self : ChemdescgeometricSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemdescgeometricSeries::variance(self : ChemdescgeometricSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemdescgeometricSeries::std(self : ChemdescgeometricSeries) -> Double { @_common.std(self.vals) }

pub fn ChemdescgeometricSeries::median(self : ChemdescgeometricSeries) -> Double { @_common.median(self.vals) }

pub fn ChemdescgeometricSeries::scale(self : ChemdescgeometricSeries, f : Double) -> ChemdescgeometricSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemdescgeometricSeries::add(self : ChemdescgeometricSeries, other : ChemdescgeometricSeries) -> ChemdescgeometricSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemdescgeometricSeries::sub(self : ChemdescgeometricSeries, other : ChemdescgeometricSeries) -> ChemdescgeometricSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemdescgeometricSeries::normalize(self : ChemdescgeometricSeries) -> ChemdescgeometricSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemdescgeometricSeries::cumsum(self : ChemdescgeometricSeries) -> ChemdescgeometricSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemdescgeometricSeries::to_string(self : ChemdescgeometricSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemdescgeometricMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_desc_geometric_make_matrix(rows : Int, cols : Int, val : Double) -> ChemdescgeometricMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_desc_geometric_matrix_identity(n : Int) -> ChemdescgeometricMatrix {
  let m = chem_desc_geometric_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemdescgeometricMatrix::get(self : ChemdescgeometricMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemdescgeometricMatrix::transpose(self : ChemdescgeometricMatrix) -> ChemdescgeometricMatrix {
  let result = chem_desc_geometric_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemdescgeometricMatrix::add(self : ChemdescgeometricMatrix, other : ChemdescgeometricMatrix) -> ChemdescgeometricMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_desc_geometric_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemdescgeometricMatrix::scale(self : ChemdescgeometricMatrix, s : Double) -> ChemdescgeometricMatrix {
  let result = chem_desc_geometric_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemdescgeometricMatrix::multiply(self : ChemdescgeometricMatrix, other : ChemdescgeometricMatrix) -> ChemdescgeometricMatrix {
  if self.cols != other.rows { return chem_desc_geometric_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_desc_geometric_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn ChemdescgeometricMatrix::trace(self : ChemdescgeometricMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemdescgeometricMatrix::det(self : ChemdescgeometricMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemdescgeometricMatrix::norm(self : ChemdescgeometricMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemdescgeometricMatrix::to_string(self : ChemdescgeometricMatrix) -> String {
  let mut result = "Mat(" + self.rows.to_string() + "x" + self.cols.to_string() + ")\n"
  let rl = if self.rows < 5 { self.rows } else { 5 }
  let cl = if self.cols < 5 { self.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + @_common.dbl(self.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct ChemdescgeometricVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_desc_geometric_make_vector(comps : Array[Double]) -> ChemdescgeometricVector {
  { comps, dim: comps.length() }
}

pub fn chem_desc_geometric_vector_zero(dim : Int) -> ChemdescgeometricVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemdescgeometricVector::add(self : ChemdescgeometricVector, other : ChemdescgeometricVector) -> ChemdescgeometricVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemdescgeometricVector::sub(self : ChemdescgeometricVector, other : ChemdescgeometricVector) -> ChemdescgeometricVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemdescgeometricVector::scale(self : ChemdescgeometricVector, s : Double) -> ChemdescgeometricVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemdescgeometricVector::dot(self : ChemdescgeometricVector, other : ChemdescgeometricVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemdescgeometricVector::norm(self : ChemdescgeometricVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemdescgeometricVector::normalize(self : ChemdescgeometricVector) -> ChemdescgeometricVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemdescgeometricVector::dist(self : ChemdescgeometricVector, other : ChemdescgeometricVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemdescgeometricVector::to_string(self : ChemdescgeometricVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemdescgeometricFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_geometric_frame_make(size : Int) -> ChemdescgeometricFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescgeometricFrame::len(self : ChemdescgeometricFrame) -> Int { self.size }

pub fn ChemdescgeometricFrame::get(self : ChemdescgeometricFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescgeometricFrame::set(self : ChemdescgeometricFrame, i : Int, v : Double) -> ChemdescgeometricFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricFrame::sum(self : ChemdescgeometricFrame) -> Double { @_common.sum(self.data) }

pub fn ChemdescgeometricFrame::mean(self : ChemdescgeometricFrame) -> Double { @_common.mean(self.data) }

pub fn ChemdescgeometricFrame::scale(self : ChemdescgeometricFrame, f : Double) -> ChemdescgeometricFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricFrame::add(self : ChemdescgeometricFrame, other : ChemdescgeometricFrame) -> ChemdescgeometricFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescgeometricFrame::copy(self : ChemdescgeometricFrame) -> ChemdescgeometricFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricFrame::fill(self : ChemdescgeometricFrame, v : Double) -> ChemdescgeometricFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricFrame::min(self : ChemdescgeometricFrame) -> Double { @_common.min(self.data) }

pub fn ChemdescgeometricFrame::max(self : ChemdescgeometricFrame) -> Double { @_common.max(self.data) }

pub fn ChemdescgeometricFrame::to_string(self : ChemdescgeometricFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescgeometricTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_geometric_table_make(size : Int) -> ChemdescgeometricTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescgeometricTable::len(self : ChemdescgeometricTable) -> Int { self.size }

pub fn ChemdescgeometricTable::get(self : ChemdescgeometricTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescgeometricTable::set(self : ChemdescgeometricTable, i : Int, v : Double) -> ChemdescgeometricTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricTable::sum(self : ChemdescgeometricTable) -> Double { @_common.sum(self.data) }

pub fn ChemdescgeometricTable::mean(self : ChemdescgeometricTable) -> Double { @_common.mean(self.data) }

pub fn ChemdescgeometricTable::scale(self : ChemdescgeometricTable, f : Double) -> ChemdescgeometricTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricTable::add(self : ChemdescgeometricTable, other : ChemdescgeometricTable) -> ChemdescgeometricTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescgeometricTable::copy(self : ChemdescgeometricTable) -> ChemdescgeometricTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricTable::fill(self : ChemdescgeometricTable, v : Double) -> ChemdescgeometricTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricTable::min(self : ChemdescgeometricTable) -> Double { @_common.min(self.data) }

pub fn ChemdescgeometricTable::max(self : ChemdescgeometricTable) -> Double { @_common.max(self.data) }

pub fn ChemdescgeometricTable::to_string(self : ChemdescgeometricTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescgeometricGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_geometric_graphn_make(size : Int) -> ChemdescgeometricGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescgeometricGraphN::len(self : ChemdescgeometricGraphN) -> Int { self.size }

pub fn ChemdescgeometricGraphN::get(self : ChemdescgeometricGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescgeometricGraphN::set(self : ChemdescgeometricGraphN, i : Int, v : Double) -> ChemdescgeometricGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricGraphN::sum(self : ChemdescgeometricGraphN) -> Double { @_common.sum(self.data) }

pub fn ChemdescgeometricGraphN::mean(self : ChemdescgeometricGraphN) -> Double { @_common.mean(self.data) }

pub fn ChemdescgeometricGraphN::scale(self : ChemdescgeometricGraphN, f : Double) -> ChemdescgeometricGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricGraphN::add(self : ChemdescgeometricGraphN, other : ChemdescgeometricGraphN) -> ChemdescgeometricGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescgeometricGraphN::copy(self : ChemdescgeometricGraphN) -> ChemdescgeometricGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricGraphN::fill(self : ChemdescgeometricGraphN, v : Double) -> ChemdescgeometricGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricGraphN::min(self : ChemdescgeometricGraphN) -> Double { @_common.min(self.data) }

pub fn ChemdescgeometricGraphN::max(self : ChemdescgeometricGraphN) -> Double { @_common.max(self.data) }

pub fn ChemdescgeometricGraphN::to_string(self : ChemdescgeometricGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescgeometricNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_geometric_node_make(size : Int) -> ChemdescgeometricNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescgeometricNode::len(self : ChemdescgeometricNode) -> Int { self.size }

pub fn ChemdescgeometricNode::get(self : ChemdescgeometricNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescgeometricNode::set(self : ChemdescgeometricNode, i : Int, v : Double) -> ChemdescgeometricNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricNode::sum(self : ChemdescgeometricNode) -> Double { @_common.sum(self.data) }

pub fn ChemdescgeometricNode::mean(self : ChemdescgeometricNode) -> Double { @_common.mean(self.data) }

pub fn ChemdescgeometricNode::scale(self : ChemdescgeometricNode, f : Double) -> ChemdescgeometricNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricNode::add(self : ChemdescgeometricNode, other : ChemdescgeometricNode) -> ChemdescgeometricNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescgeometricNode::copy(self : ChemdescgeometricNode) -> ChemdescgeometricNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricNode::fill(self : ChemdescgeometricNode, v : Double) -> ChemdescgeometricNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricNode::min(self : ChemdescgeometricNode) -> Double { @_common.min(self.data) }

pub fn ChemdescgeometricNode::max(self : ChemdescgeometricNode) -> Double { @_common.max(self.data) }

pub fn ChemdescgeometricNode::to_string(self : ChemdescgeometricNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescgeometricEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_geometric_edge_make(size : Int) -> ChemdescgeometricEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescgeometricEdge::len(self : ChemdescgeometricEdge) -> Int { self.size }

pub fn ChemdescgeometricEdge::get(self : ChemdescgeometricEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescgeometricEdge::set(self : ChemdescgeometricEdge, i : Int, v : Double) -> ChemdescgeometricEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricEdge::sum(self : ChemdescgeometricEdge) -> Double { @_common.sum(self.data) }

pub fn ChemdescgeometricEdge::mean(self : ChemdescgeometricEdge) -> Double { @_common.mean(self.data) }

pub fn ChemdescgeometricEdge::scale(self : ChemdescgeometricEdge, f : Double) -> ChemdescgeometricEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricEdge::add(self : ChemdescgeometricEdge, other : ChemdescgeometricEdge) -> ChemdescgeometricEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescgeometricEdge::copy(self : ChemdescgeometricEdge) -> ChemdescgeometricEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricEdge::fill(self : ChemdescgeometricEdge, v : Double) -> ChemdescgeometricEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricEdge::min(self : ChemdescgeometricEdge) -> Double { @_common.min(self.data) }

pub fn ChemdescgeometricEdge::max(self : ChemdescgeometricEdge) -> Double { @_common.max(self.data) }

pub fn ChemdescgeometricEdge::to_string(self : ChemdescgeometricEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescgeometricPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_geometric_path_make(size : Int) -> ChemdescgeometricPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescgeometricPath::len(self : ChemdescgeometricPath) -> Int { self.size }

pub fn ChemdescgeometricPath::get(self : ChemdescgeometricPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescgeometricPath::set(self : ChemdescgeometricPath, i : Int, v : Double) -> ChemdescgeometricPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricPath::sum(self : ChemdescgeometricPath) -> Double { @_common.sum(self.data) }

pub fn ChemdescgeometricPath::mean(self : ChemdescgeometricPath) -> Double { @_common.mean(self.data) }

pub fn ChemdescgeometricPath::scale(self : ChemdescgeometricPath, f : Double) -> ChemdescgeometricPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricPath::add(self : ChemdescgeometricPath, other : ChemdescgeometricPath) -> ChemdescgeometricPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescgeometricPath::copy(self : ChemdescgeometricPath) -> ChemdescgeometricPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricPath::fill(self : ChemdescgeometricPath, v : Double) -> ChemdescgeometricPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricPath::min(self : ChemdescgeometricPath) -> Double { @_common.min(self.data) }

pub fn ChemdescgeometricPath::max(self : ChemdescgeometricPath) -> Double { @_common.max(self.data) }

pub fn ChemdescgeometricPath::to_string(self : ChemdescgeometricPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescgeometricCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_geometric_cluster_make(size : Int) -> ChemdescgeometricCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescgeometricCluster::len(self : ChemdescgeometricCluster) -> Int { self.size }

pub fn ChemdescgeometricCluster::get(self : ChemdescgeometricCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescgeometricCluster::set(self : ChemdescgeometricCluster, i : Int, v : Double) -> ChemdescgeometricCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricCluster::sum(self : ChemdescgeometricCluster) -> Double { @_common.sum(self.data) }

pub fn ChemdescgeometricCluster::mean(self : ChemdescgeometricCluster) -> Double { @_common.mean(self.data) }

pub fn ChemdescgeometricCluster::scale(self : ChemdescgeometricCluster, f : Double) -> ChemdescgeometricCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricCluster::add(self : ChemdescgeometricCluster, other : ChemdescgeometricCluster) -> ChemdescgeometricCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescgeometricCluster::copy(self : ChemdescgeometricCluster) -> ChemdescgeometricCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricCluster::fill(self : ChemdescgeometricCluster, v : Double) -> ChemdescgeometricCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricCluster::min(self : ChemdescgeometricCluster) -> Double { @_common.min(self.data) }

pub fn ChemdescgeometricCluster::max(self : ChemdescgeometricCluster) -> Double { @_common.max(self.data) }

pub fn ChemdescgeometricCluster::to_string(self : ChemdescgeometricCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescgeometricModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_geometric_model_make(size : Int) -> ChemdescgeometricModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescgeometricModel::len(self : ChemdescgeometricModel) -> Int { self.size }

pub fn ChemdescgeometricModel::get(self : ChemdescgeometricModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescgeometricModel::set(self : ChemdescgeometricModel, i : Int, v : Double) -> ChemdescgeometricModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricModel::sum(self : ChemdescgeometricModel) -> Double { @_common.sum(self.data) }

pub fn ChemdescgeometricModel::mean(self : ChemdescgeometricModel) -> Double { @_common.mean(self.data) }

pub fn ChemdescgeometricModel::scale(self : ChemdescgeometricModel, f : Double) -> ChemdescgeometricModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricModel::add(self : ChemdescgeometricModel, other : ChemdescgeometricModel) -> ChemdescgeometricModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescgeometricModel::copy(self : ChemdescgeometricModel) -> ChemdescgeometricModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricModel::fill(self : ChemdescgeometricModel, v : Double) -> ChemdescgeometricModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricModel::min(self : ChemdescgeometricModel) -> Double { @_common.min(self.data) }

pub fn ChemdescgeometricModel::max(self : ChemdescgeometricModel) -> Double { @_common.max(self.data) }

pub fn ChemdescgeometricModel::to_string(self : ChemdescgeometricModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescgeometricLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_geometric_layer_make(size : Int) -> ChemdescgeometricLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescgeometricLayer::len(self : ChemdescgeometricLayer) -> Int { self.size }

pub fn ChemdescgeometricLayer::get(self : ChemdescgeometricLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescgeometricLayer::set(self : ChemdescgeometricLayer, i : Int, v : Double) -> ChemdescgeometricLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricLayer::sum(self : ChemdescgeometricLayer) -> Double { @_common.sum(self.data) }

pub fn ChemdescgeometricLayer::mean(self : ChemdescgeometricLayer) -> Double { @_common.mean(self.data) }

pub fn ChemdescgeometricLayer::scale(self : ChemdescgeometricLayer, f : Double) -> ChemdescgeometricLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricLayer::add(self : ChemdescgeometricLayer, other : ChemdescgeometricLayer) -> ChemdescgeometricLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescgeometricLayer::copy(self : ChemdescgeometricLayer) -> ChemdescgeometricLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricLayer::fill(self : ChemdescgeometricLayer, v : Double) -> ChemdescgeometricLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricLayer::min(self : ChemdescgeometricLayer) -> Double { @_common.min(self.data) }

pub fn ChemdescgeometricLayer::max(self : ChemdescgeometricLayer) -> Double { @_common.max(self.data) }

pub fn ChemdescgeometricLayer::to_string(self : ChemdescgeometricLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescgeometricBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_geometric_buffer_make(size : Int) -> ChemdescgeometricBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescgeometricBuffer::len(self : ChemdescgeometricBuffer) -> Int { self.size }

pub fn ChemdescgeometricBuffer::get(self : ChemdescgeometricBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescgeometricBuffer::set(self : ChemdescgeometricBuffer, i : Int, v : Double) -> ChemdescgeometricBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricBuffer::sum(self : ChemdescgeometricBuffer) -> Double { @_common.sum(self.data) }

pub fn ChemdescgeometricBuffer::mean(self : ChemdescgeometricBuffer) -> Double { @_common.mean(self.data) }

pub fn ChemdescgeometricBuffer::scale(self : ChemdescgeometricBuffer, f : Double) -> ChemdescgeometricBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricBuffer::add(self : ChemdescgeometricBuffer, other : ChemdescgeometricBuffer) -> ChemdescgeometricBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescgeometricBuffer::copy(self : ChemdescgeometricBuffer) -> ChemdescgeometricBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricBuffer::fill(self : ChemdescgeometricBuffer, v : Double) -> ChemdescgeometricBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricBuffer::min(self : ChemdescgeometricBuffer) -> Double { @_common.min(self.data) }

pub fn ChemdescgeometricBuffer::max(self : ChemdescgeometricBuffer) -> Double { @_common.max(self.data) }

pub fn ChemdescgeometricBuffer::to_string(self : ChemdescgeometricBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescgeometricCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_geometric_cursor_make(size : Int) -> ChemdescgeometricCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescgeometricCursor::len(self : ChemdescgeometricCursor) -> Int { self.size }

pub fn ChemdescgeometricCursor::get(self : ChemdescgeometricCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescgeometricCursor::set(self : ChemdescgeometricCursor, i : Int, v : Double) -> ChemdescgeometricCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricCursor::sum(self : ChemdescgeometricCursor) -> Double { @_common.sum(self.data) }

pub fn ChemdescgeometricCursor::mean(self : ChemdescgeometricCursor) -> Double { @_common.mean(self.data) }

pub fn ChemdescgeometricCursor::scale(self : ChemdescgeometricCursor, f : Double) -> ChemdescgeometricCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricCursor::add(self : ChemdescgeometricCursor, other : ChemdescgeometricCursor) -> ChemdescgeometricCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescgeometricCursor::copy(self : ChemdescgeometricCursor) -> ChemdescgeometricCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricCursor::fill(self : ChemdescgeometricCursor, v : Double) -> ChemdescgeometricCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricCursor::min(self : ChemdescgeometricCursor) -> Double { @_common.min(self.data) }

pub fn ChemdescgeometricCursor::max(self : ChemdescgeometricCursor) -> Double { @_common.max(self.data) }

pub fn ChemdescgeometricCursor::to_string(self : ChemdescgeometricCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescgeometricView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_geometric_view_make(size : Int) -> ChemdescgeometricView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescgeometricView::len(self : ChemdescgeometricView) -> Int { self.size }

pub fn ChemdescgeometricView::get(self : ChemdescgeometricView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescgeometricView::set(self : ChemdescgeometricView, i : Int, v : Double) -> ChemdescgeometricView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricView::sum(self : ChemdescgeometricView) -> Double { @_common.sum(self.data) }

pub fn ChemdescgeometricView::mean(self : ChemdescgeometricView) -> Double { @_common.mean(self.data) }

pub fn ChemdescgeometricView::scale(self : ChemdescgeometricView, f : Double) -> ChemdescgeometricView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricView::add(self : ChemdescgeometricView, other : ChemdescgeometricView) -> ChemdescgeometricView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescgeometricView::copy(self : ChemdescgeometricView) -> ChemdescgeometricView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricView::fill(self : ChemdescgeometricView, v : Double) -> ChemdescgeometricView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricView::min(self : ChemdescgeometricView) -> Double { @_common.min(self.data) }

pub fn ChemdescgeometricView::max(self : ChemdescgeometricView) -> Double { @_common.max(self.data) }

pub fn ChemdescgeometricView::to_string(self : ChemdescgeometricView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescgeometricRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_geometric_range_make(size : Int) -> ChemdescgeometricRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescgeometricRange::len(self : ChemdescgeometricRange) -> Int { self.size }

pub fn ChemdescgeometricRange::get(self : ChemdescgeometricRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescgeometricRange::set(self : ChemdescgeometricRange, i : Int, v : Double) -> ChemdescgeometricRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricRange::sum(self : ChemdescgeometricRange) -> Double { @_common.sum(self.data) }

pub fn ChemdescgeometricRange::mean(self : ChemdescgeometricRange) -> Double { @_common.mean(self.data) }

pub fn ChemdescgeometricRange::scale(self : ChemdescgeometricRange, f : Double) -> ChemdescgeometricRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricRange::add(self : ChemdescgeometricRange, other : ChemdescgeometricRange) -> ChemdescgeometricRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescgeometricRange::copy(self : ChemdescgeometricRange) -> ChemdescgeometricRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricRange::fill(self : ChemdescgeometricRange, v : Double) -> ChemdescgeometricRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricRange::min(self : ChemdescgeometricRange) -> Double { @_common.min(self.data) }

pub fn ChemdescgeometricRange::max(self : ChemdescgeometricRange) -> Double { @_common.max(self.data) }

pub fn ChemdescgeometricRange::to_string(self : ChemdescgeometricRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescgeometricSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_geometric_slice_make(size : Int) -> ChemdescgeometricSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescgeometricSlice::len(self : ChemdescgeometricSlice) -> Int { self.size }

pub fn ChemdescgeometricSlice::get(self : ChemdescgeometricSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescgeometricSlice::set(self : ChemdescgeometricSlice, i : Int, v : Double) -> ChemdescgeometricSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricSlice::sum(self : ChemdescgeometricSlice) -> Double { @_common.sum(self.data) }

pub fn ChemdescgeometricSlice::mean(self : ChemdescgeometricSlice) -> Double { @_common.mean(self.data) }

pub fn ChemdescgeometricSlice::scale(self : ChemdescgeometricSlice, f : Double) -> ChemdescgeometricSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricSlice::add(self : ChemdescgeometricSlice, other : ChemdescgeometricSlice) -> ChemdescgeometricSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescgeometricSlice::copy(self : ChemdescgeometricSlice) -> ChemdescgeometricSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricSlice::fill(self : ChemdescgeometricSlice, v : Double) -> ChemdescgeometricSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescgeometricSlice::min(self : ChemdescgeometricSlice) -> Double { @_common.min(self.data) }

pub fn ChemdescgeometricSlice::max(self : ChemdescgeometricSlice) -> Double { @_common.max(self.data) }

pub fn ChemdescgeometricSlice::to_string(self : ChemdescgeometricSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

