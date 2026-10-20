///===
/// extcore/db_store_series

pub(all) struct DbstoreseriesPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_store_series_make_point(x : Double, y : Double) -> DbstoreseriesPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_store_series_make_point3(x : Double, y : Double, z : Double) -> DbstoreseriesPoint {
  { x, y, z, label: 0 }
}

pub fn DbstoreseriesPoint::x(self : DbstoreseriesPoint) -> Double { self.x }

pub fn DbstoreseriesPoint::y(self : DbstoreseriesPoint) -> Double { self.y }

pub fn DbstoreseriesPoint::z(self : DbstoreseriesPoint) -> Double { self.z }

pub fn DbstoreseriesPoint::label(self : DbstoreseriesPoint) -> Int { self.label }

pub fn DbstoreseriesPoint::dist(self : DbstoreseriesPoint, other : DbstoreseriesPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbstoreseriesPoint::add(self : DbstoreseriesPoint, other : DbstoreseriesPoint) -> DbstoreseriesPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbstoreseriesPoint::sub(self : DbstoreseriesPoint, other : DbstoreseriesPoint) -> DbstoreseriesPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbstoreseriesPoint::scale(self : DbstoreseriesPoint, s : Double) -> DbstoreseriesPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbstoreseriesPoint::dot(self : DbstoreseriesPoint, other : DbstoreseriesPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbstoreseriesPoint::cross(self : DbstoreseriesPoint, other : DbstoreseriesPoint) -> DbstoreseriesPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbstoreseriesPoint::norm(self : DbstoreseriesPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbstoreseriesPoint::normalize(self : DbstoreseriesPoint) -> DbstoreseriesPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbstoreseriesPoint::negate(self : DbstoreseriesPoint) -> DbstoreseriesPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbstoreseriesPoint::mid(self : DbstoreseriesPoint, other : DbstoreseriesPoint) -> DbstoreseriesPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbstoreseriesPoint::lerp(self : DbstoreseriesPoint, other : DbstoreseriesPoint, t : Double) -> DbstoreseriesPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbstoreseriesPoint::to_string(self : DbstoreseriesPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbstoreseriesSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_store_series_make_series(vals : Array[Double], name : String) -> DbstoreseriesSeries {
  { vals, name, meta: 0 }
}

pub fn DbstoreseriesSeries::len(self : DbstoreseriesSeries) -> Int { self.vals.length() }

pub fn DbstoreseriesSeries::sum(self : DbstoreseriesSeries) -> Double { @_common.sum(self.vals) }

pub fn DbstoreseriesSeries::mean(self : DbstoreseriesSeries) -> Double { @_common.mean(self.vals) }

pub fn DbstoreseriesSeries::min(self : DbstoreseriesSeries) -> Double { @_common.min(self.vals) }

pub fn DbstoreseriesSeries::max(self : DbstoreseriesSeries) -> Double { @_common.max(self.vals) }

pub fn DbstoreseriesSeries::range(self : DbstoreseriesSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbstoreseriesSeries::variance(self : DbstoreseriesSeries) -> Double { @_common.variance(self.vals) }

pub fn DbstoreseriesSeries::std(self : DbstoreseriesSeries) -> Double { @_common.std(self.vals) }

pub fn DbstoreseriesSeries::median(self : DbstoreseriesSeries) -> Double { @_common.median(self.vals) }

pub fn DbstoreseriesSeries::scale(self : DbstoreseriesSeries, f : Double) -> DbstoreseriesSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbstoreseriesSeries::add(self : DbstoreseriesSeries, other : DbstoreseriesSeries) -> DbstoreseriesSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbstoreseriesSeries::sub(self : DbstoreseriesSeries, other : DbstoreseriesSeries) -> DbstoreseriesSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbstoreseriesSeries::normalize(self : DbstoreseriesSeries) -> DbstoreseriesSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbstoreseriesSeries::cumsum(self : DbstoreseriesSeries) -> DbstoreseriesSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbstoreseriesSeries::to_string(self : DbstoreseriesSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbstoreseriesMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_store_series_make_matrix(rows : Int, cols : Int, val : Double) -> DbstoreseriesMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn db_store_series_matrix_identity(n : Int) -> DbstoreseriesMatrix {
  let m = db_store_series_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbstoreseriesMatrix::get(self : DbstoreseriesMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbstoreseriesMatrix::transpose(self : DbstoreseriesMatrix) -> DbstoreseriesMatrix {
  let result = db_store_series_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbstoreseriesMatrix::add(self : DbstoreseriesMatrix, other : DbstoreseriesMatrix) -> DbstoreseriesMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_store_series_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbstoreseriesMatrix::scale(self : DbstoreseriesMatrix, s : Double) -> DbstoreseriesMatrix {
  let result = db_store_series_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbstoreseriesMatrix::multiply(self : DbstoreseriesMatrix, other : DbstoreseriesMatrix) -> DbstoreseriesMatrix {
  if self.cols != other.rows { return db_store_series_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_store_series_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn DbstoreseriesMatrix::trace(self : DbstoreseriesMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbstoreseriesMatrix::det(self : DbstoreseriesMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbstoreseriesMatrix::norm(self : DbstoreseriesMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbstoreseriesMatrix::to_string(self : DbstoreseriesMatrix) -> String {
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

pub(all) struct DbstoreseriesVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_store_series_make_vector(comps : Array[Double]) -> DbstoreseriesVector {
  { comps, dim: comps.length() }
}

pub fn db_store_series_vector_zero(dim : Int) -> DbstoreseriesVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbstoreseriesVector::add(self : DbstoreseriesVector, other : DbstoreseriesVector) -> DbstoreseriesVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbstoreseriesVector::sub(self : DbstoreseriesVector, other : DbstoreseriesVector) -> DbstoreseriesVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbstoreseriesVector::scale(self : DbstoreseriesVector, s : Double) -> DbstoreseriesVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbstoreseriesVector::dot(self : DbstoreseriesVector, other : DbstoreseriesVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbstoreseriesVector::norm(self : DbstoreseriesVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbstoreseriesVector::normalize(self : DbstoreseriesVector) -> DbstoreseriesVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbstoreseriesVector::dist(self : DbstoreseriesVector, other : DbstoreseriesVector) -> Double {
  self.sub(other).norm()
}

pub fn DbstoreseriesVector::to_string(self : DbstoreseriesVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbstoreseriesFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_series_frame_make(size : Int) -> DbstoreseriesFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoreseriesFrame::len(self : DbstoreseriesFrame) -> Int { self.size }

pub fn DbstoreseriesFrame::get(self : DbstoreseriesFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoreseriesFrame::set(self : DbstoreseriesFrame, i : Int, v : Double) -> DbstoreseriesFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoreseriesFrame::sum(self : DbstoreseriesFrame) -> Double { @_common.sum(self.data) }

pub fn DbstoreseriesFrame::mean(self : DbstoreseriesFrame) -> Double { @_common.mean(self.data) }

pub fn DbstoreseriesFrame::scale(self : DbstoreseriesFrame, f : Double) -> DbstoreseriesFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoreseriesFrame::add(self : DbstoreseriesFrame, other : DbstoreseriesFrame) -> DbstoreseriesFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoreseriesFrame::copy(self : DbstoreseriesFrame) -> DbstoreseriesFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoreseriesFrame::fill(self : DbstoreseriesFrame, v : Double) -> DbstoreseriesFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoreseriesFrame::min(self : DbstoreseriesFrame) -> Double { @_common.min(self.data) }

pub fn DbstoreseriesFrame::max(self : DbstoreseriesFrame) -> Double { @_common.max(self.data) }

pub fn DbstoreseriesFrame::to_string(self : DbstoreseriesFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoreseriesTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_series_table_make(size : Int) -> DbstoreseriesTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoreseriesTable::len(self : DbstoreseriesTable) -> Int { self.size }

pub fn DbstoreseriesTable::get(self : DbstoreseriesTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoreseriesTable::set(self : DbstoreseriesTable, i : Int, v : Double) -> DbstoreseriesTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoreseriesTable::sum(self : DbstoreseriesTable) -> Double { @_common.sum(self.data) }

pub fn DbstoreseriesTable::mean(self : DbstoreseriesTable) -> Double { @_common.mean(self.data) }

pub fn DbstoreseriesTable::scale(self : DbstoreseriesTable, f : Double) -> DbstoreseriesTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoreseriesTable::add(self : DbstoreseriesTable, other : DbstoreseriesTable) -> DbstoreseriesTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoreseriesTable::copy(self : DbstoreseriesTable) -> DbstoreseriesTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoreseriesTable::fill(self : DbstoreseriesTable, v : Double) -> DbstoreseriesTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoreseriesTable::min(self : DbstoreseriesTable) -> Double { @_common.min(self.data) }

pub fn DbstoreseriesTable::max(self : DbstoreseriesTable) -> Double { @_common.max(self.data) }

pub fn DbstoreseriesTable::to_string(self : DbstoreseriesTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoreseriesGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_series_graphn_make(size : Int) -> DbstoreseriesGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoreseriesGraphN::len(self : DbstoreseriesGraphN) -> Int { self.size }

pub fn DbstoreseriesGraphN::get(self : DbstoreseriesGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoreseriesGraphN::set(self : DbstoreseriesGraphN, i : Int, v : Double) -> DbstoreseriesGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoreseriesGraphN::sum(self : DbstoreseriesGraphN) -> Double { @_common.sum(self.data) }

pub fn DbstoreseriesGraphN::mean(self : DbstoreseriesGraphN) -> Double { @_common.mean(self.data) }

pub fn DbstoreseriesGraphN::scale(self : DbstoreseriesGraphN, f : Double) -> DbstoreseriesGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoreseriesGraphN::add(self : DbstoreseriesGraphN, other : DbstoreseriesGraphN) -> DbstoreseriesGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoreseriesGraphN::copy(self : DbstoreseriesGraphN) -> DbstoreseriesGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoreseriesGraphN::fill(self : DbstoreseriesGraphN, v : Double) -> DbstoreseriesGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoreseriesGraphN::min(self : DbstoreseriesGraphN) -> Double { @_common.min(self.data) }

pub fn DbstoreseriesGraphN::max(self : DbstoreseriesGraphN) -> Double { @_common.max(self.data) }

pub fn DbstoreseriesGraphN::to_string(self : DbstoreseriesGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoreseriesNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_series_node_make(size : Int) -> DbstoreseriesNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoreseriesNode::len(self : DbstoreseriesNode) -> Int { self.size }

pub fn DbstoreseriesNode::get(self : DbstoreseriesNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoreseriesNode::set(self : DbstoreseriesNode, i : Int, v : Double) -> DbstoreseriesNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoreseriesNode::sum(self : DbstoreseriesNode) -> Double { @_common.sum(self.data) }

pub fn DbstoreseriesNode::mean(self : DbstoreseriesNode) -> Double { @_common.mean(self.data) }

pub fn DbstoreseriesNode::scale(self : DbstoreseriesNode, f : Double) -> DbstoreseriesNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoreseriesNode::add(self : DbstoreseriesNode, other : DbstoreseriesNode) -> DbstoreseriesNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoreseriesNode::copy(self : DbstoreseriesNode) -> DbstoreseriesNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoreseriesNode::fill(self : DbstoreseriesNode, v : Double) -> DbstoreseriesNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoreseriesNode::min(self : DbstoreseriesNode) -> Double { @_common.min(self.data) }

pub fn DbstoreseriesNode::max(self : DbstoreseriesNode) -> Double { @_common.max(self.data) }

pub fn DbstoreseriesNode::to_string(self : DbstoreseriesNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoreseriesEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_series_edge_make(size : Int) -> DbstoreseriesEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoreseriesEdge::len(self : DbstoreseriesEdge) -> Int { self.size }

pub fn DbstoreseriesEdge::get(self : DbstoreseriesEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoreseriesEdge::set(self : DbstoreseriesEdge, i : Int, v : Double) -> DbstoreseriesEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoreseriesEdge::sum(self : DbstoreseriesEdge) -> Double { @_common.sum(self.data) }

pub fn DbstoreseriesEdge::mean(self : DbstoreseriesEdge) -> Double { @_common.mean(self.data) }

pub fn DbstoreseriesEdge::scale(self : DbstoreseriesEdge, f : Double) -> DbstoreseriesEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoreseriesEdge::add(self : DbstoreseriesEdge, other : DbstoreseriesEdge) -> DbstoreseriesEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoreseriesEdge::copy(self : DbstoreseriesEdge) -> DbstoreseriesEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoreseriesEdge::fill(self : DbstoreseriesEdge, v : Double) -> DbstoreseriesEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoreseriesEdge::min(self : DbstoreseriesEdge) -> Double { @_common.min(self.data) }

pub fn DbstoreseriesEdge::max(self : DbstoreseriesEdge) -> Double { @_common.max(self.data) }

pub fn DbstoreseriesEdge::to_string(self : DbstoreseriesEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoreseriesPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_series_path_make(size : Int) -> DbstoreseriesPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoreseriesPath::len(self : DbstoreseriesPath) -> Int { self.size }

pub fn DbstoreseriesPath::get(self : DbstoreseriesPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoreseriesPath::set(self : DbstoreseriesPath, i : Int, v : Double) -> DbstoreseriesPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoreseriesPath::sum(self : DbstoreseriesPath) -> Double { @_common.sum(self.data) }

pub fn DbstoreseriesPath::mean(self : DbstoreseriesPath) -> Double { @_common.mean(self.data) }

pub fn DbstoreseriesPath::scale(self : DbstoreseriesPath, f : Double) -> DbstoreseriesPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoreseriesPath::add(self : DbstoreseriesPath, other : DbstoreseriesPath) -> DbstoreseriesPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoreseriesPath::copy(self : DbstoreseriesPath) -> DbstoreseriesPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoreseriesPath::fill(self : DbstoreseriesPath, v : Double) -> DbstoreseriesPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoreseriesPath::min(self : DbstoreseriesPath) -> Double { @_common.min(self.data) }

pub fn DbstoreseriesPath::max(self : DbstoreseriesPath) -> Double { @_common.max(self.data) }

pub fn DbstoreseriesPath::to_string(self : DbstoreseriesPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoreseriesCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_series_cluster_make(size : Int) -> DbstoreseriesCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoreseriesCluster::len(self : DbstoreseriesCluster) -> Int { self.size }

pub fn DbstoreseriesCluster::get(self : DbstoreseriesCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoreseriesCluster::set(self : DbstoreseriesCluster, i : Int, v : Double) -> DbstoreseriesCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoreseriesCluster::sum(self : DbstoreseriesCluster) -> Double { @_common.sum(self.data) }

pub fn DbstoreseriesCluster::mean(self : DbstoreseriesCluster) -> Double { @_common.mean(self.data) }

pub fn DbstoreseriesCluster::scale(self : DbstoreseriesCluster, f : Double) -> DbstoreseriesCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoreseriesCluster::add(self : DbstoreseriesCluster, other : DbstoreseriesCluster) -> DbstoreseriesCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoreseriesCluster::copy(self : DbstoreseriesCluster) -> DbstoreseriesCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoreseriesCluster::fill(self : DbstoreseriesCluster, v : Double) -> DbstoreseriesCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoreseriesCluster::min(self : DbstoreseriesCluster) -> Double { @_common.min(self.data) }

pub fn DbstoreseriesCluster::max(self : DbstoreseriesCluster) -> Double { @_common.max(self.data) }

pub fn DbstoreseriesCluster::to_string(self : DbstoreseriesCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoreseriesModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_series_model_make(size : Int) -> DbstoreseriesModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoreseriesModel::len(self : DbstoreseriesModel) -> Int { self.size }

pub fn DbstoreseriesModel::get(self : DbstoreseriesModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoreseriesModel::set(self : DbstoreseriesModel, i : Int, v : Double) -> DbstoreseriesModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoreseriesModel::sum(self : DbstoreseriesModel) -> Double { @_common.sum(self.data) }

pub fn DbstoreseriesModel::mean(self : DbstoreseriesModel) -> Double { @_common.mean(self.data) }

pub fn DbstoreseriesModel::scale(self : DbstoreseriesModel, f : Double) -> DbstoreseriesModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoreseriesModel::add(self : DbstoreseriesModel, other : DbstoreseriesModel) -> DbstoreseriesModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoreseriesModel::copy(self : DbstoreseriesModel) -> DbstoreseriesModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoreseriesModel::fill(self : DbstoreseriesModel, v : Double) -> DbstoreseriesModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoreseriesModel::min(self : DbstoreseriesModel) -> Double { @_common.min(self.data) }

pub fn DbstoreseriesModel::max(self : DbstoreseriesModel) -> Double { @_common.max(self.data) }

pub fn DbstoreseriesModel::to_string(self : DbstoreseriesModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoreseriesLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_series_layer_make(size : Int) -> DbstoreseriesLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoreseriesLayer::len(self : DbstoreseriesLayer) -> Int { self.size }

pub fn DbstoreseriesLayer::get(self : DbstoreseriesLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoreseriesLayer::set(self : DbstoreseriesLayer, i : Int, v : Double) -> DbstoreseriesLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoreseriesLayer::sum(self : DbstoreseriesLayer) -> Double { @_common.sum(self.data) }

pub fn DbstoreseriesLayer::mean(self : DbstoreseriesLayer) -> Double { @_common.mean(self.data) }

pub fn DbstoreseriesLayer::scale(self : DbstoreseriesLayer, f : Double) -> DbstoreseriesLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoreseriesLayer::add(self : DbstoreseriesLayer, other : DbstoreseriesLayer) -> DbstoreseriesLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoreseriesLayer::copy(self : DbstoreseriesLayer) -> DbstoreseriesLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoreseriesLayer::fill(self : DbstoreseriesLayer, v : Double) -> DbstoreseriesLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoreseriesLayer::min(self : DbstoreseriesLayer) -> Double { @_common.min(self.data) }

pub fn DbstoreseriesLayer::max(self : DbstoreseriesLayer) -> Double { @_common.max(self.data) }

pub fn DbstoreseriesLayer::to_string(self : DbstoreseriesLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoreseriesBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_series_buffer_make(size : Int) -> DbstoreseriesBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoreseriesBuffer::len(self : DbstoreseriesBuffer) -> Int { self.size }

pub fn DbstoreseriesBuffer::get(self : DbstoreseriesBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoreseriesBuffer::set(self : DbstoreseriesBuffer, i : Int, v : Double) -> DbstoreseriesBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoreseriesBuffer::sum(self : DbstoreseriesBuffer) -> Double { @_common.sum(self.data) }

pub fn DbstoreseriesBuffer::mean(self : DbstoreseriesBuffer) -> Double { @_common.mean(self.data) }

pub fn DbstoreseriesBuffer::scale(self : DbstoreseriesBuffer, f : Double) -> DbstoreseriesBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoreseriesBuffer::add(self : DbstoreseriesBuffer, other : DbstoreseriesBuffer) -> DbstoreseriesBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoreseriesBuffer::copy(self : DbstoreseriesBuffer) -> DbstoreseriesBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoreseriesBuffer::fill(self : DbstoreseriesBuffer, v : Double) -> DbstoreseriesBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoreseriesBuffer::min(self : DbstoreseriesBuffer) -> Double { @_common.min(self.data) }

pub fn DbstoreseriesBuffer::max(self : DbstoreseriesBuffer) -> Double { @_common.max(self.data) }

pub fn DbstoreseriesBuffer::to_string(self : DbstoreseriesBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoreseriesCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_series_cursor_make(size : Int) -> DbstoreseriesCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoreseriesCursor::len(self : DbstoreseriesCursor) -> Int { self.size }

pub fn DbstoreseriesCursor::get(self : DbstoreseriesCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoreseriesCursor::set(self : DbstoreseriesCursor, i : Int, v : Double) -> DbstoreseriesCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoreseriesCursor::sum(self : DbstoreseriesCursor) -> Double { @_common.sum(self.data) }

pub fn DbstoreseriesCursor::mean(self : DbstoreseriesCursor) -> Double { @_common.mean(self.data) }

pub fn DbstoreseriesCursor::scale(self : DbstoreseriesCursor, f : Double) -> DbstoreseriesCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoreseriesCursor::add(self : DbstoreseriesCursor, other : DbstoreseriesCursor) -> DbstoreseriesCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoreseriesCursor::copy(self : DbstoreseriesCursor) -> DbstoreseriesCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoreseriesCursor::fill(self : DbstoreseriesCursor, v : Double) -> DbstoreseriesCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoreseriesCursor::min(self : DbstoreseriesCursor) -> Double { @_common.min(self.data) }

pub fn DbstoreseriesCursor::max(self : DbstoreseriesCursor) -> Double { @_common.max(self.data) }

pub fn DbstoreseriesCursor::to_string(self : DbstoreseriesCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoreseriesView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_series_view_make(size : Int) -> DbstoreseriesView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoreseriesView::len(self : DbstoreseriesView) -> Int { self.size }

pub fn DbstoreseriesView::get(self : DbstoreseriesView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoreseriesView::set(self : DbstoreseriesView, i : Int, v : Double) -> DbstoreseriesView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoreseriesView::sum(self : DbstoreseriesView) -> Double { @_common.sum(self.data) }

pub fn DbstoreseriesView::mean(self : DbstoreseriesView) -> Double { @_common.mean(self.data) }

pub fn DbstoreseriesView::scale(self : DbstoreseriesView, f : Double) -> DbstoreseriesView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoreseriesView::add(self : DbstoreseriesView, other : DbstoreseriesView) -> DbstoreseriesView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoreseriesView::copy(self : DbstoreseriesView) -> DbstoreseriesView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoreseriesView::fill(self : DbstoreseriesView, v : Double) -> DbstoreseriesView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoreseriesView::min(self : DbstoreseriesView) -> Double { @_common.min(self.data) }

pub fn DbstoreseriesView::max(self : DbstoreseriesView) -> Double { @_common.max(self.data) }

pub fn DbstoreseriesView::to_string(self : DbstoreseriesView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoreseriesRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_series_range_make(size : Int) -> DbstoreseriesRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoreseriesRange::len(self : DbstoreseriesRange) -> Int { self.size }

pub fn DbstoreseriesRange::get(self : DbstoreseriesRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoreseriesRange::set(self : DbstoreseriesRange, i : Int, v : Double) -> DbstoreseriesRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoreseriesRange::sum(self : DbstoreseriesRange) -> Double { @_common.sum(self.data) }

pub fn DbstoreseriesRange::mean(self : DbstoreseriesRange) -> Double { @_common.mean(self.data) }

pub fn DbstoreseriesRange::scale(self : DbstoreseriesRange, f : Double) -> DbstoreseriesRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoreseriesRange::add(self : DbstoreseriesRange, other : DbstoreseriesRange) -> DbstoreseriesRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoreseriesRange::copy(self : DbstoreseriesRange) -> DbstoreseriesRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoreseriesRange::fill(self : DbstoreseriesRange, v : Double) -> DbstoreseriesRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoreseriesRange::min(self : DbstoreseriesRange) -> Double { @_common.min(self.data) }

pub fn DbstoreseriesRange::max(self : DbstoreseriesRange) -> Double { @_common.max(self.data) }

pub fn DbstoreseriesRange::to_string(self : DbstoreseriesRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoreseriesSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_series_slice_make(size : Int) -> DbstoreseriesSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoreseriesSlice::len(self : DbstoreseriesSlice) -> Int { self.size }

pub fn DbstoreseriesSlice::get(self : DbstoreseriesSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoreseriesSlice::set(self : DbstoreseriesSlice, i : Int, v : Double) -> DbstoreseriesSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoreseriesSlice::sum(self : DbstoreseriesSlice) -> Double { @_common.sum(self.data) }

pub fn DbstoreseriesSlice::mean(self : DbstoreseriesSlice) -> Double { @_common.mean(self.data) }

pub fn DbstoreseriesSlice::scale(self : DbstoreseriesSlice, f : Double) -> DbstoreseriesSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoreseriesSlice::add(self : DbstoreseriesSlice, other : DbstoreseriesSlice) -> DbstoreseriesSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoreseriesSlice::copy(self : DbstoreseriesSlice) -> DbstoreseriesSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoreseriesSlice::fill(self : DbstoreseriesSlice, v : Double) -> DbstoreseriesSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoreseriesSlice::min(self : DbstoreseriesSlice) -> Double { @_common.min(self.data) }

pub fn DbstoreseriesSlice::max(self : DbstoreseriesSlice) -> Double { @_common.max(self.data) }

pub fn DbstoreseriesSlice::to_string(self : DbstoreseriesSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

