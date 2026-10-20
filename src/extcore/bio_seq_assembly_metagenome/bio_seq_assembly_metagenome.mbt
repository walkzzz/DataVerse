///===
/// extcore/bio_seq_assembly_metagenome

pub(all) struct BioseqassemblymetagenomePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_assembly_metagenome_make_point(x : Double, y : Double) -> BioseqassemblymetagenomePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_assembly_metagenome_make_point3(x : Double, y : Double, z : Double) -> BioseqassemblymetagenomePoint {
  { x, y, z, label: 0 }
}

pub fn BioseqassemblymetagenomePoint::x(self : BioseqassemblymetagenomePoint) -> Double { self.x }

pub fn BioseqassemblymetagenomePoint::y(self : BioseqassemblymetagenomePoint) -> Double { self.y }

pub fn BioseqassemblymetagenomePoint::z(self : BioseqassemblymetagenomePoint) -> Double { self.z }

pub fn BioseqassemblymetagenomePoint::label(self : BioseqassemblymetagenomePoint) -> Int { self.label }

pub fn BioseqassemblymetagenomePoint::dist(self : BioseqassemblymetagenomePoint, other : BioseqassemblymetagenomePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BioseqassemblymetagenomePoint::add(self : BioseqassemblymetagenomePoint, other : BioseqassemblymetagenomePoint) -> BioseqassemblymetagenomePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BioseqassemblymetagenomePoint::sub(self : BioseqassemblymetagenomePoint, other : BioseqassemblymetagenomePoint) -> BioseqassemblymetagenomePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BioseqassemblymetagenomePoint::scale(self : BioseqassemblymetagenomePoint, s : Double) -> BioseqassemblymetagenomePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BioseqassemblymetagenomePoint::dot(self : BioseqassemblymetagenomePoint, other : BioseqassemblymetagenomePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BioseqassemblymetagenomePoint::cross(self : BioseqassemblymetagenomePoint, other : BioseqassemblymetagenomePoint) -> BioseqassemblymetagenomePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BioseqassemblymetagenomePoint::norm(self : BioseqassemblymetagenomePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BioseqassemblymetagenomePoint::normalize(self : BioseqassemblymetagenomePoint) -> BioseqassemblymetagenomePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqassemblymetagenomePoint::negate(self : BioseqassemblymetagenomePoint) -> BioseqassemblymetagenomePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BioseqassemblymetagenomePoint::mid(self : BioseqassemblymetagenomePoint, other : BioseqassemblymetagenomePoint) -> BioseqassemblymetagenomePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BioseqassemblymetagenomePoint::lerp(self : BioseqassemblymetagenomePoint, other : BioseqassemblymetagenomePoint, t : Double) -> BioseqassemblymetagenomePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BioseqassemblymetagenomePoint::to_string(self : BioseqassemblymetagenomePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BioseqassemblymetagenomeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_assembly_metagenome_make_series(vals : Array[Double], name : String) -> BioseqassemblymetagenomeSeries {
  { vals, name, meta: 0 }
}

pub fn BioseqassemblymetagenomeSeries::len(self : BioseqassemblymetagenomeSeries) -> Int { self.vals.length() }

pub fn BioseqassemblymetagenomeSeries::sum(self : BioseqassemblymetagenomeSeries) -> Double { @_common.sum(self.vals) }

pub fn BioseqassemblymetagenomeSeries::mean(self : BioseqassemblymetagenomeSeries) -> Double { @_common.mean(self.vals) }

pub fn BioseqassemblymetagenomeSeries::min(self : BioseqassemblymetagenomeSeries) -> Double { @_common.min(self.vals) }

pub fn BioseqassemblymetagenomeSeries::max(self : BioseqassemblymetagenomeSeries) -> Double { @_common.max(self.vals) }

pub fn BioseqassemblymetagenomeSeries::range(self : BioseqassemblymetagenomeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BioseqassemblymetagenomeSeries::variance(self : BioseqassemblymetagenomeSeries) -> Double { @_common.variance(self.vals) }

pub fn BioseqassemblymetagenomeSeries::std(self : BioseqassemblymetagenomeSeries) -> Double { @_common.std(self.vals) }

pub fn BioseqassemblymetagenomeSeries::median(self : BioseqassemblymetagenomeSeries) -> Double { @_common.median(self.vals) }

pub fn BioseqassemblymetagenomeSeries::scale(self : BioseqassemblymetagenomeSeries, f : Double) -> BioseqassemblymetagenomeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BioseqassemblymetagenomeSeries::add(self : BioseqassemblymetagenomeSeries, other : BioseqassemblymetagenomeSeries) -> BioseqassemblymetagenomeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BioseqassemblymetagenomeSeries::sub(self : BioseqassemblymetagenomeSeries, other : BioseqassemblymetagenomeSeries) -> BioseqassemblymetagenomeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BioseqassemblymetagenomeSeries::normalize(self : BioseqassemblymetagenomeSeries) -> BioseqassemblymetagenomeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BioseqassemblymetagenomeSeries::cumsum(self : BioseqassemblymetagenomeSeries) -> BioseqassemblymetagenomeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BioseqassemblymetagenomeSeries::to_string(self : BioseqassemblymetagenomeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqassemblymetagenomeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_assembly_metagenome_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqassemblymetagenomeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_assembly_metagenome_matrix_identity(n : Int) -> BioseqassemblymetagenomeMatrix {
  let m = bio_seq_assembly_metagenome_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BioseqassemblymetagenomeMatrix::get(self : BioseqassemblymetagenomeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BioseqassemblymetagenomeMatrix::transpose(self : BioseqassemblymetagenomeMatrix) -> BioseqassemblymetagenomeMatrix {
  let result = bio_seq_assembly_metagenome_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BioseqassemblymetagenomeMatrix::add(self : BioseqassemblymetagenomeMatrix, other : BioseqassemblymetagenomeMatrix) -> BioseqassemblymetagenomeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_seq_assembly_metagenome_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BioseqassemblymetagenomeMatrix::scale(self : BioseqassemblymetagenomeMatrix, s : Double) -> BioseqassemblymetagenomeMatrix {
  let result = bio_seq_assembly_metagenome_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BioseqassemblymetagenomeMatrix::multiply(self : BioseqassemblymetagenomeMatrix, other : BioseqassemblymetagenomeMatrix) -> BioseqassemblymetagenomeMatrix {
  if self.cols != other.rows { return bio_seq_assembly_metagenome_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_seq_assembly_metagenome_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn BioseqassemblymetagenomeMatrix::trace(self : BioseqassemblymetagenomeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BioseqassemblymetagenomeMatrix::det(self : BioseqassemblymetagenomeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BioseqassemblymetagenomeMatrix::norm(self : BioseqassemblymetagenomeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BioseqassemblymetagenomeMatrix::to_string(self : BioseqassemblymetagenomeMatrix) -> String {
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

pub(all) struct BioseqassemblymetagenomeVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_assembly_metagenome_make_vector(comps : Array[Double]) -> BioseqassemblymetagenomeVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_assembly_metagenome_vector_zero(dim : Int) -> BioseqassemblymetagenomeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BioseqassemblymetagenomeVector::add(self : BioseqassemblymetagenomeVector, other : BioseqassemblymetagenomeVector) -> BioseqassemblymetagenomeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqassemblymetagenomeVector::sub(self : BioseqassemblymetagenomeVector, other : BioseqassemblymetagenomeVector) -> BioseqassemblymetagenomeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqassemblymetagenomeVector::scale(self : BioseqassemblymetagenomeVector, s : Double) -> BioseqassemblymetagenomeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BioseqassemblymetagenomeVector::dot(self : BioseqassemblymetagenomeVector, other : BioseqassemblymetagenomeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BioseqassemblymetagenomeVector::norm(self : BioseqassemblymetagenomeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BioseqassemblymetagenomeVector::normalize(self : BioseqassemblymetagenomeVector) -> BioseqassemblymetagenomeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqassemblymetagenomeVector::dist(self : BioseqassemblymetagenomeVector, other : BioseqassemblymetagenomeVector) -> Double {
  self.sub(other).norm()
}

pub fn BioseqassemblymetagenomeVector::to_string(self : BioseqassemblymetagenomeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqassemblymetagenomeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_metagenome_frame_make(size : Int) -> BioseqassemblymetagenomeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblymetagenomeFrame::len(self : BioseqassemblymetagenomeFrame) -> Int { self.size }

pub fn BioseqassemblymetagenomeFrame::get(self : BioseqassemblymetagenomeFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblymetagenomeFrame::set(self : BioseqassemblymetagenomeFrame, i : Int, v : Double) -> BioseqassemblymetagenomeFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeFrame::sum(self : BioseqassemblymetagenomeFrame) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblymetagenomeFrame::mean(self : BioseqassemblymetagenomeFrame) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblymetagenomeFrame::scale(self : BioseqassemblymetagenomeFrame, f : Double) -> BioseqassemblymetagenomeFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeFrame::add(self : BioseqassemblymetagenomeFrame, other : BioseqassemblymetagenomeFrame) -> BioseqassemblymetagenomeFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblymetagenomeFrame::copy(self : BioseqassemblymetagenomeFrame) -> BioseqassemblymetagenomeFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeFrame::fill(self : BioseqassemblymetagenomeFrame, v : Double) -> BioseqassemblymetagenomeFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeFrame::min(self : BioseqassemblymetagenomeFrame) -> Double { @_common.min(self.data) }

pub fn BioseqassemblymetagenomeFrame::max(self : BioseqassemblymetagenomeFrame) -> Double { @_common.max(self.data) }

pub fn BioseqassemblymetagenomeFrame::to_string(self : BioseqassemblymetagenomeFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblymetagenomeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_metagenome_table_make(size : Int) -> BioseqassemblymetagenomeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblymetagenomeTable::len(self : BioseqassemblymetagenomeTable) -> Int { self.size }

pub fn BioseqassemblymetagenomeTable::get(self : BioseqassemblymetagenomeTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblymetagenomeTable::set(self : BioseqassemblymetagenomeTable, i : Int, v : Double) -> BioseqassemblymetagenomeTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeTable::sum(self : BioseqassemblymetagenomeTable) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblymetagenomeTable::mean(self : BioseqassemblymetagenomeTable) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblymetagenomeTable::scale(self : BioseqassemblymetagenomeTable, f : Double) -> BioseqassemblymetagenomeTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeTable::add(self : BioseqassemblymetagenomeTable, other : BioseqassemblymetagenomeTable) -> BioseqassemblymetagenomeTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblymetagenomeTable::copy(self : BioseqassemblymetagenomeTable) -> BioseqassemblymetagenomeTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeTable::fill(self : BioseqassemblymetagenomeTable, v : Double) -> BioseqassemblymetagenomeTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeTable::min(self : BioseqassemblymetagenomeTable) -> Double { @_common.min(self.data) }

pub fn BioseqassemblymetagenomeTable::max(self : BioseqassemblymetagenomeTable) -> Double { @_common.max(self.data) }

pub fn BioseqassemblymetagenomeTable::to_string(self : BioseqassemblymetagenomeTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblymetagenomeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_metagenome_graphn_make(size : Int) -> BioseqassemblymetagenomeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblymetagenomeGraphN::len(self : BioseqassemblymetagenomeGraphN) -> Int { self.size }

pub fn BioseqassemblymetagenomeGraphN::get(self : BioseqassemblymetagenomeGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblymetagenomeGraphN::set(self : BioseqassemblymetagenomeGraphN, i : Int, v : Double) -> BioseqassemblymetagenomeGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeGraphN::sum(self : BioseqassemblymetagenomeGraphN) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblymetagenomeGraphN::mean(self : BioseqassemblymetagenomeGraphN) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblymetagenomeGraphN::scale(self : BioseqassemblymetagenomeGraphN, f : Double) -> BioseqassemblymetagenomeGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeGraphN::add(self : BioseqassemblymetagenomeGraphN, other : BioseqassemblymetagenomeGraphN) -> BioseqassemblymetagenomeGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblymetagenomeGraphN::copy(self : BioseqassemblymetagenomeGraphN) -> BioseqassemblymetagenomeGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeGraphN::fill(self : BioseqassemblymetagenomeGraphN, v : Double) -> BioseqassemblymetagenomeGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeGraphN::min(self : BioseqassemblymetagenomeGraphN) -> Double { @_common.min(self.data) }

pub fn BioseqassemblymetagenomeGraphN::max(self : BioseqassemblymetagenomeGraphN) -> Double { @_common.max(self.data) }

pub fn BioseqassemblymetagenomeGraphN::to_string(self : BioseqassemblymetagenomeGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblymetagenomeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_metagenome_node_make(size : Int) -> BioseqassemblymetagenomeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblymetagenomeNode::len(self : BioseqassemblymetagenomeNode) -> Int { self.size }

pub fn BioseqassemblymetagenomeNode::get(self : BioseqassemblymetagenomeNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblymetagenomeNode::set(self : BioseqassemblymetagenomeNode, i : Int, v : Double) -> BioseqassemblymetagenomeNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeNode::sum(self : BioseqassemblymetagenomeNode) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblymetagenomeNode::mean(self : BioseqassemblymetagenomeNode) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblymetagenomeNode::scale(self : BioseqassemblymetagenomeNode, f : Double) -> BioseqassemblymetagenomeNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeNode::add(self : BioseqassemblymetagenomeNode, other : BioseqassemblymetagenomeNode) -> BioseqassemblymetagenomeNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblymetagenomeNode::copy(self : BioseqassemblymetagenomeNode) -> BioseqassemblymetagenomeNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeNode::fill(self : BioseqassemblymetagenomeNode, v : Double) -> BioseqassemblymetagenomeNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeNode::min(self : BioseqassemblymetagenomeNode) -> Double { @_common.min(self.data) }

pub fn BioseqassemblymetagenomeNode::max(self : BioseqassemblymetagenomeNode) -> Double { @_common.max(self.data) }

pub fn BioseqassemblymetagenomeNode::to_string(self : BioseqassemblymetagenomeNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblymetagenomeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_metagenome_edge_make(size : Int) -> BioseqassemblymetagenomeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblymetagenomeEdge::len(self : BioseqassemblymetagenomeEdge) -> Int { self.size }

pub fn BioseqassemblymetagenomeEdge::get(self : BioseqassemblymetagenomeEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblymetagenomeEdge::set(self : BioseqassemblymetagenomeEdge, i : Int, v : Double) -> BioseqassemblymetagenomeEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeEdge::sum(self : BioseqassemblymetagenomeEdge) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblymetagenomeEdge::mean(self : BioseqassemblymetagenomeEdge) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblymetagenomeEdge::scale(self : BioseqassemblymetagenomeEdge, f : Double) -> BioseqassemblymetagenomeEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeEdge::add(self : BioseqassemblymetagenomeEdge, other : BioseqassemblymetagenomeEdge) -> BioseqassemblymetagenomeEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblymetagenomeEdge::copy(self : BioseqassemblymetagenomeEdge) -> BioseqassemblymetagenomeEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeEdge::fill(self : BioseqassemblymetagenomeEdge, v : Double) -> BioseqassemblymetagenomeEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeEdge::min(self : BioseqassemblymetagenomeEdge) -> Double { @_common.min(self.data) }

pub fn BioseqassemblymetagenomeEdge::max(self : BioseqassemblymetagenomeEdge) -> Double { @_common.max(self.data) }

pub fn BioseqassemblymetagenomeEdge::to_string(self : BioseqassemblymetagenomeEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblymetagenomePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_metagenome_path_make(size : Int) -> BioseqassemblymetagenomePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblymetagenomePath::len(self : BioseqassemblymetagenomePath) -> Int { self.size }

pub fn BioseqassemblymetagenomePath::get(self : BioseqassemblymetagenomePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblymetagenomePath::set(self : BioseqassemblymetagenomePath, i : Int, v : Double) -> BioseqassemblymetagenomePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomePath::sum(self : BioseqassemblymetagenomePath) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblymetagenomePath::mean(self : BioseqassemblymetagenomePath) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblymetagenomePath::scale(self : BioseqassemblymetagenomePath, f : Double) -> BioseqassemblymetagenomePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomePath::add(self : BioseqassemblymetagenomePath, other : BioseqassemblymetagenomePath) -> BioseqassemblymetagenomePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblymetagenomePath::copy(self : BioseqassemblymetagenomePath) -> BioseqassemblymetagenomePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomePath::fill(self : BioseqassemblymetagenomePath, v : Double) -> BioseqassemblymetagenomePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomePath::min(self : BioseqassemblymetagenomePath) -> Double { @_common.min(self.data) }

pub fn BioseqassemblymetagenomePath::max(self : BioseqassemblymetagenomePath) -> Double { @_common.max(self.data) }

pub fn BioseqassemblymetagenomePath::to_string(self : BioseqassemblymetagenomePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblymetagenomeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_metagenome_cluster_make(size : Int) -> BioseqassemblymetagenomeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblymetagenomeCluster::len(self : BioseqassemblymetagenomeCluster) -> Int { self.size }

pub fn BioseqassemblymetagenomeCluster::get(self : BioseqassemblymetagenomeCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblymetagenomeCluster::set(self : BioseqassemblymetagenomeCluster, i : Int, v : Double) -> BioseqassemblymetagenomeCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeCluster::sum(self : BioseqassemblymetagenomeCluster) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblymetagenomeCluster::mean(self : BioseqassemblymetagenomeCluster) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblymetagenomeCluster::scale(self : BioseqassemblymetagenomeCluster, f : Double) -> BioseqassemblymetagenomeCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeCluster::add(self : BioseqassemblymetagenomeCluster, other : BioseqassemblymetagenomeCluster) -> BioseqassemblymetagenomeCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblymetagenomeCluster::copy(self : BioseqassemblymetagenomeCluster) -> BioseqassemblymetagenomeCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeCluster::fill(self : BioseqassemblymetagenomeCluster, v : Double) -> BioseqassemblymetagenomeCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeCluster::min(self : BioseqassemblymetagenomeCluster) -> Double { @_common.min(self.data) }

pub fn BioseqassemblymetagenomeCluster::max(self : BioseqassemblymetagenomeCluster) -> Double { @_common.max(self.data) }

pub fn BioseqassemblymetagenomeCluster::to_string(self : BioseqassemblymetagenomeCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblymetagenomeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_metagenome_model_make(size : Int) -> BioseqassemblymetagenomeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblymetagenomeModel::len(self : BioseqassemblymetagenomeModel) -> Int { self.size }

pub fn BioseqassemblymetagenomeModel::get(self : BioseqassemblymetagenomeModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblymetagenomeModel::set(self : BioseqassemblymetagenomeModel, i : Int, v : Double) -> BioseqassemblymetagenomeModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeModel::sum(self : BioseqassemblymetagenomeModel) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblymetagenomeModel::mean(self : BioseqassemblymetagenomeModel) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblymetagenomeModel::scale(self : BioseqassemblymetagenomeModel, f : Double) -> BioseqassemblymetagenomeModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeModel::add(self : BioseqassemblymetagenomeModel, other : BioseqassemblymetagenomeModel) -> BioseqassemblymetagenomeModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblymetagenomeModel::copy(self : BioseqassemblymetagenomeModel) -> BioseqassemblymetagenomeModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeModel::fill(self : BioseqassemblymetagenomeModel, v : Double) -> BioseqassemblymetagenomeModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeModel::min(self : BioseqassemblymetagenomeModel) -> Double { @_common.min(self.data) }

pub fn BioseqassemblymetagenomeModel::max(self : BioseqassemblymetagenomeModel) -> Double { @_common.max(self.data) }

pub fn BioseqassemblymetagenomeModel::to_string(self : BioseqassemblymetagenomeModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblymetagenomeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_metagenome_layer_make(size : Int) -> BioseqassemblymetagenomeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblymetagenomeLayer::len(self : BioseqassemblymetagenomeLayer) -> Int { self.size }

pub fn BioseqassemblymetagenomeLayer::get(self : BioseqassemblymetagenomeLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblymetagenomeLayer::set(self : BioseqassemblymetagenomeLayer, i : Int, v : Double) -> BioseqassemblymetagenomeLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeLayer::sum(self : BioseqassemblymetagenomeLayer) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblymetagenomeLayer::mean(self : BioseqassemblymetagenomeLayer) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblymetagenomeLayer::scale(self : BioseqassemblymetagenomeLayer, f : Double) -> BioseqassemblymetagenomeLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeLayer::add(self : BioseqassemblymetagenomeLayer, other : BioseqassemblymetagenomeLayer) -> BioseqassemblymetagenomeLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblymetagenomeLayer::copy(self : BioseqassemblymetagenomeLayer) -> BioseqassemblymetagenomeLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeLayer::fill(self : BioseqassemblymetagenomeLayer, v : Double) -> BioseqassemblymetagenomeLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeLayer::min(self : BioseqassemblymetagenomeLayer) -> Double { @_common.min(self.data) }

pub fn BioseqassemblymetagenomeLayer::max(self : BioseqassemblymetagenomeLayer) -> Double { @_common.max(self.data) }

pub fn BioseqassemblymetagenomeLayer::to_string(self : BioseqassemblymetagenomeLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblymetagenomeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_metagenome_buffer_make(size : Int) -> BioseqassemblymetagenomeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblymetagenomeBuffer::len(self : BioseqassemblymetagenomeBuffer) -> Int { self.size }

pub fn BioseqassemblymetagenomeBuffer::get(self : BioseqassemblymetagenomeBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblymetagenomeBuffer::set(self : BioseqassemblymetagenomeBuffer, i : Int, v : Double) -> BioseqassemblymetagenomeBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeBuffer::sum(self : BioseqassemblymetagenomeBuffer) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblymetagenomeBuffer::mean(self : BioseqassemblymetagenomeBuffer) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblymetagenomeBuffer::scale(self : BioseqassemblymetagenomeBuffer, f : Double) -> BioseqassemblymetagenomeBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeBuffer::add(self : BioseqassemblymetagenomeBuffer, other : BioseqassemblymetagenomeBuffer) -> BioseqassemblymetagenomeBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblymetagenomeBuffer::copy(self : BioseqassemblymetagenomeBuffer) -> BioseqassemblymetagenomeBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeBuffer::fill(self : BioseqassemblymetagenomeBuffer, v : Double) -> BioseqassemblymetagenomeBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeBuffer::min(self : BioseqassemblymetagenomeBuffer) -> Double { @_common.min(self.data) }

pub fn BioseqassemblymetagenomeBuffer::max(self : BioseqassemblymetagenomeBuffer) -> Double { @_common.max(self.data) }

pub fn BioseqassemblymetagenomeBuffer::to_string(self : BioseqassemblymetagenomeBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblymetagenomeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_metagenome_cursor_make(size : Int) -> BioseqassemblymetagenomeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblymetagenomeCursor::len(self : BioseqassemblymetagenomeCursor) -> Int { self.size }

pub fn BioseqassemblymetagenomeCursor::get(self : BioseqassemblymetagenomeCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblymetagenomeCursor::set(self : BioseqassemblymetagenomeCursor, i : Int, v : Double) -> BioseqassemblymetagenomeCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeCursor::sum(self : BioseqassemblymetagenomeCursor) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblymetagenomeCursor::mean(self : BioseqassemblymetagenomeCursor) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblymetagenomeCursor::scale(self : BioseqassemblymetagenomeCursor, f : Double) -> BioseqassemblymetagenomeCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeCursor::add(self : BioseqassemblymetagenomeCursor, other : BioseqassemblymetagenomeCursor) -> BioseqassemblymetagenomeCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblymetagenomeCursor::copy(self : BioseqassemblymetagenomeCursor) -> BioseqassemblymetagenomeCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeCursor::fill(self : BioseqassemblymetagenomeCursor, v : Double) -> BioseqassemblymetagenomeCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeCursor::min(self : BioseqassemblymetagenomeCursor) -> Double { @_common.min(self.data) }

pub fn BioseqassemblymetagenomeCursor::max(self : BioseqassemblymetagenomeCursor) -> Double { @_common.max(self.data) }

pub fn BioseqassemblymetagenomeCursor::to_string(self : BioseqassemblymetagenomeCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblymetagenomeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_metagenome_view_make(size : Int) -> BioseqassemblymetagenomeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblymetagenomeView::len(self : BioseqassemblymetagenomeView) -> Int { self.size }

pub fn BioseqassemblymetagenomeView::get(self : BioseqassemblymetagenomeView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblymetagenomeView::set(self : BioseqassemblymetagenomeView, i : Int, v : Double) -> BioseqassemblymetagenomeView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeView::sum(self : BioseqassemblymetagenomeView) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblymetagenomeView::mean(self : BioseqassemblymetagenomeView) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblymetagenomeView::scale(self : BioseqassemblymetagenomeView, f : Double) -> BioseqassemblymetagenomeView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeView::add(self : BioseqassemblymetagenomeView, other : BioseqassemblymetagenomeView) -> BioseqassemblymetagenomeView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblymetagenomeView::copy(self : BioseqassemblymetagenomeView) -> BioseqassemblymetagenomeView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeView::fill(self : BioseqassemblymetagenomeView, v : Double) -> BioseqassemblymetagenomeView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeView::min(self : BioseqassemblymetagenomeView) -> Double { @_common.min(self.data) }

pub fn BioseqassemblymetagenomeView::max(self : BioseqassemblymetagenomeView) -> Double { @_common.max(self.data) }

pub fn BioseqassemblymetagenomeView::to_string(self : BioseqassemblymetagenomeView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblymetagenomeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_metagenome_range_make(size : Int) -> BioseqassemblymetagenomeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblymetagenomeRange::len(self : BioseqassemblymetagenomeRange) -> Int { self.size }

pub fn BioseqassemblymetagenomeRange::get(self : BioseqassemblymetagenomeRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblymetagenomeRange::set(self : BioseqassemblymetagenomeRange, i : Int, v : Double) -> BioseqassemblymetagenomeRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeRange::sum(self : BioseqassemblymetagenomeRange) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblymetagenomeRange::mean(self : BioseqassemblymetagenomeRange) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblymetagenomeRange::scale(self : BioseqassemblymetagenomeRange, f : Double) -> BioseqassemblymetagenomeRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeRange::add(self : BioseqassemblymetagenomeRange, other : BioseqassemblymetagenomeRange) -> BioseqassemblymetagenomeRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblymetagenomeRange::copy(self : BioseqassemblymetagenomeRange) -> BioseqassemblymetagenomeRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeRange::fill(self : BioseqassemblymetagenomeRange, v : Double) -> BioseqassemblymetagenomeRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeRange::min(self : BioseqassemblymetagenomeRange) -> Double { @_common.min(self.data) }

pub fn BioseqassemblymetagenomeRange::max(self : BioseqassemblymetagenomeRange) -> Double { @_common.max(self.data) }

pub fn BioseqassemblymetagenomeRange::to_string(self : BioseqassemblymetagenomeRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblymetagenomeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_metagenome_slice_make(size : Int) -> BioseqassemblymetagenomeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblymetagenomeSlice::len(self : BioseqassemblymetagenomeSlice) -> Int { self.size }

pub fn BioseqassemblymetagenomeSlice::get(self : BioseqassemblymetagenomeSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblymetagenomeSlice::set(self : BioseqassemblymetagenomeSlice, i : Int, v : Double) -> BioseqassemblymetagenomeSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeSlice::sum(self : BioseqassemblymetagenomeSlice) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblymetagenomeSlice::mean(self : BioseqassemblymetagenomeSlice) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblymetagenomeSlice::scale(self : BioseqassemblymetagenomeSlice, f : Double) -> BioseqassemblymetagenomeSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeSlice::add(self : BioseqassemblymetagenomeSlice, other : BioseqassemblymetagenomeSlice) -> BioseqassemblymetagenomeSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblymetagenomeSlice::copy(self : BioseqassemblymetagenomeSlice) -> BioseqassemblymetagenomeSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeSlice::fill(self : BioseqassemblymetagenomeSlice, v : Double) -> BioseqassemblymetagenomeSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblymetagenomeSlice::min(self : BioseqassemblymetagenomeSlice) -> Double { @_common.min(self.data) }

pub fn BioseqassemblymetagenomeSlice::max(self : BioseqassemblymetagenomeSlice) -> Double { @_common.max(self.data) }

pub fn BioseqassemblymetagenomeSlice::to_string(self : BioseqassemblymetagenomeSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

